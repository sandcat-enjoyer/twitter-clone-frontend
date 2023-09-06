import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class AccountSettings extends StatefulWidget {
  final UserLocal user;
  AccountSettings(this.user);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();

}

class _AccountSettingsState extends State<AccountSettings> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings")
      ),
      body: Text("Account Settings")
    );
  }
}