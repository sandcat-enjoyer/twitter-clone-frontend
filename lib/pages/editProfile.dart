import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class EditProfile extends StatefulWidget {
  final UserLocal user;
  EditProfile(this.user);

  @override 
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  String _newDisplayName = "";

  @override 
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return _buildPopUpDialog(context);
      }
      else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit profile"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                
              ],
            ),
          )
        );
      }

    });
  }
}

Widget _buildPopUpDialog(BuildContext context) {
  return Dialog(
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Edit Profile"),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("Save"))
        ],
      ),
    ),
  );
}