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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              return CircularProgressIndicator();
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return Text("Post not found.");
            } else {
              Map<String, dynamic> postData = snapshot.data!.data()!;
              DocumentReference userRef = postData["user"] as DocumentReference;

              return FutureBuilder(
                future: userRef.get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (userSnapshot.hasError) {
                    return Text("Error: ${userSnapshot.error}");
                  } else if (!userSnapshot.hasData ||
                      userSnapshot.data!.data() == null) {
                    return Text("User not found.");
                  } else {
                    Map<String, dynamic> userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;

                    return ListView(
                      padding: EdgeInsets.all(16),
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
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData["displayname"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(userData["username"])
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        // Bolt Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(postData["content"],
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 16)
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("${postData['likes']} Likes",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(width: 20),
                            Text("${postData['rebolts']} Rebolts",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.bolt_rounded),
                              onPressed: () {},
                            ),
                            SizedBox(width: 20),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_rounded)),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.repeat_rounded),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(Icons.ios_share_rounded),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Replies",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
