import "package:flutter/material.dart";

import "../data/user.dart";

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required User user, required int postId})
    : _user = user,
      _postId = postId,
      super(key: key);
  
  final User _user;
  final int _postId;

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
        title: Text("Bolt Details", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Post ID given is: ${widget._postId}')
      ),
    );
  }
}