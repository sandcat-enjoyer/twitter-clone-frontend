import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";
import "package:spark/widgets/expandedImagePage.dart";

import "../data/user.dart";

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required UserLocal user, required String postId})
      : _user = user,
        _postId = postId,
        super(key: key);

  final UserLocal _user;
  final String _postId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isLiked = false;
  int _likesCount = 0;
  List<Map<String, dynamic>> _replies = [];
  @override
  void initState() {
    super.initState();
    fetchReplies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  

  Future<void> fetchReplies() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("posts")
        .doc(widget._postId)
        .collection("replies")
        .orderBy("timestamp", descending: true)
        .get();

    setState(() {
      print(snapshot.docs.map((e) => e.data()).toList());
      _replies = snapshot.docs.map((e) => e.data()).toList();
    });
  }

Future<List<DocumentReference<Object?>>> _fetchLikedBy(String postId) async {
  final postReference = FirebaseFirestore.instance.collection("posts").doc(postId);
  final postSnapshot = await postReference.get();
  final List<dynamic> likedBy = postSnapshot.get("likedBy");
  
  // Convert likedBy to a List<DocumentReference>
  final List<DocumentReference<Object?>> likedByRefs = likedBy.cast<DocumentReference<Object?>>().toList();

  return likedByRefs;
}

_buildLikedByDialog() async {
  try {
    final likedByRefs = await _fetchLikedBy(widget._postId);
    bool profilePictureExists;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Liked by"),
          content: Container(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: likedByRefs.length,
              itemBuilder: (context, index) {
                final userRef = likedByRefs[index];

                return FutureBuilder(
                  future: userRef.get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (userSnapshot.hasError) {
                      return Text("Error: ${userSnapshot.error}");
                    }

                    if (!userSnapshot.hasData ||
                        userSnapshot.data!.data() == null) {
                      return Text("User not found");
                    }

                    final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                    print(userData);
                    final displayName = userData["displayname"];
                    final username = userData["username"];
                    final profilePictureUrl = userData["profilePictureUrl"];
                    if (userData["profilePictureUrl"] != null && userData["profilePictureUrl"] != ""){
                      profilePictureExists = true;
                    }
                    else {
                      profilePictureExists = false;
                    }

                    return ListTile(
                      leading: profilePictureExists ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profilePictureUrl),
                      ) : CircleAvatar(
                        radius: 25,
                        child: Text(displayName.substring(0,1).toUpperCase()) ,
                      ),
                      title: Text(displayName),
                      subtitle: Text(username),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print("Error fetching liked usernames: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bolt Details"),
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("posts")
              .doc(widget._postId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Text("Post not found.");
            } else {
              Map<String, dynamic> postData = snapshot.data!.data()!;
              DocumentReference userRef = postData["user"] as DocumentReference;

              return FutureBuilder(
                future: userRef.get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (userSnapshot.hasError) {
                    return Text("Error: ${userSnapshot.error}");
                  } else if (!userSnapshot.hasData ||
                      userSnapshot.data!.data() == null) {
                    return const Text("User not found.");
                  } else {
                    Map<String, dynamic> userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;

                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // Bolt Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (userData["profilePictureUrl"] == "") ...[
                              CircleAvatar(
                                radius: 30,
                                child: Text(userData["username"].toString().substring(0, 1), style: TextStyle(
                                  fontSize: 30
                                ),),
                              )
                            ],
                            if (userData["profilePictureUrl"] != "") ...[
                              CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(userData["profilePictureUrl"]),
                            ),
                            ],                            
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData["displayname"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(userData["username"])
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Bolt Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(postData["content"],
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 16)
                          ],
                        ),
                        if (postData["imageUrl"] != null && postData["imageUrl"] != "") ...[
                          Container(
                           
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpandedImagePage(imageUrl: postData["imageUrl"], profileDisplayName: '', profileUserName: "profileUserName", profilePictureUrl: "profilePictureUrl", boltDescription: "boltDescription", likes: postData["likes"], reposts: postData["rebolts"])));

                              },
                              child: Image.network(postData["imageUrl"],
                              
                            ),
                            
                          ) ),
                        )
                        ],
                        const Divider(),
                        Row(
                          children: [
                            TextButton(child: Text("${postData['likes']} Likes", style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white
                                    ),),
                            onPressed: () async {
                              _buildLikedByDialog();
                              

                            },
                                style: ButtonStyle(
                                    )),
                            const SizedBox(width: 20),
                            Text("${postData['rebolts']} Rebolts",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.bolt_rounded),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                                onPressed: () {
                                  // Handle like button tap
                                  if (_isLiked) {
                                    final currentUserReference = FirebaseFirestore.instance.collection("users").doc(widget._user.uid);
                                    final postReference = FirebaseFirestore.instance.collection("posts").doc(widget._postId);
                                    // If already liked, decrement likes count
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(widget._postId)
                                        .update({
                                      'likes': FieldValue.increment(-1),
                                      "likedBy": FieldValue.arrayRemove(
                                          [currentUserReference])
                                    });
                                    
                                    

                                    setState(() {
                                      _likesCount--;
                                      _isLiked = false;
                                    });
                                  } else {
                                    final currentUserReference = FirebaseFirestore.instance.collection("users").doc(widget._user.uid);
                                    final postReference = FirebaseFirestore.instance.collection("posts").doc(widget._postId);
                                    // If not liked, increment likes count
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(widget._postId)
                                        .update({
                                      'likes': FieldValue.increment(1),
                                      //temporary id assigned here, don't forget to remove this later on
                                      "likedBy": FieldValue.arrayUnion(
                                          [currentUserReference])
                                    });

                                    
                                    setState(() {
                                      _likesCount++;
                                      _isLiked = true;
                                    });
                                  }
                                },
                                icon: Icon(Icons.favorite_rounded,
                                    color: _isLiked ? Colors.red : null)),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.repeat_rounded),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.ios_share_rounded),
                              onPressed: () {},
                            )
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Replies",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _replies.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> replyData =
                                    _replies[index];
                                DocumentReference replyUserRef =
                                    replyData["user"] as DocumentReference;

                                return FutureBuilder(
                                  future: replyUserRef.get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.data() == null) {
                                      return const Text("User not found");
                                    } else {
                                      Map<String, dynamic> replyUserData =
                                          snapshot.data!.data()
                                              as Map<String, dynamic>;

                                      return ListTile(
                                        onTap: () {

                                        },
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              replyUserData[
                                                  "profilePictureUrl"]),
                                        ),
                                        title:
                                            Text(replyUserData["displayname"], style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyMedium!.color,
                                              fontWeight: FontWeight.bold
                                            )),
                                        subtitle: Text(replyData["text"]),
                                        trailing: Text(
                                          DateTime.now().toString(),
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    );
                  }
                },
              );
            }
          },
        ));
  }
}
