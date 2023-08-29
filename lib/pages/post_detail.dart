import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";

import "../data/user.dart";

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required User user, required String postId})
      : _user = user,
        _postId = postId,
        super(key: key);

  final User _user;
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
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(userData["profilePictureUrl"]),
                            ),
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
                        const Divider(),
                        Row(
                          children: [
                            Text("${postData['likes']} Likes",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                                    // If already liked, decrement likes count
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(widget._postId)
                                        .update({
                                      'likes': FieldValue.increment(-1),
                                      "likedBy": FieldValue.arrayRemove(
                                          [widget._user.uid])
                                    });
                                    setState(() {
                                      _likesCount--;
                                      _isLiked = false;
                                    });
                                  } else {
                                    // If not liked, increment likes count
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(widget._postId)
                                        .update({
                                      'likes': FieldValue.increment(1),
                                      //temporary id assigned here, don't forget to remove this later on
                                      "likedBy": FieldValue.arrayUnion(
                                          [widget._user.uid])
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
                              icon: Icon(Icons.repeat_rounded),
                            ),
                            SizedBox(width: 20),
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
                                            Text(replyUserData["displayname"], style: const TextStyle(
                                              color: Colors.white,
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
