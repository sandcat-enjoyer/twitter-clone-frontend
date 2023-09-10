import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class AccountSettings extends StatefulWidget {
  final UserLocal user;
  const AccountSettings(this.user, {super.key});

  @override
  _AccountSettingsState createState() => _AccountSettingsState();

}

class _AccountSettingsState extends State<AccountSettings> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings")
      ),
      body: const Text("Account Settings")
    );
  }
}