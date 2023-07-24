import "package:flutter/material.dart";

import "../data/user.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
    return Scaffold();
  }
}
