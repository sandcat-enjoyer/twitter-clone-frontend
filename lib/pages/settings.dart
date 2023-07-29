import "package:flutter/material.dart";

import "../data/user.dart";
import "package:settings_ui/settings_ui.dart";

class Settings extends StatefulWidget {
  const Settings({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
          title: Text("Settings"),
        ),
        body: Text("Settings"));
  }
}
