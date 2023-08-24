import "dart:io";

import "package:flutter/material.dart";
import "package:permission_handler/permission_handler.dart";

import "../data/user.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
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
    bool notificationsEnabled = false;
    return Scaffold(
      
      appBar: AppBar(
        title:
            Text('Settings', style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notifications',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Switch(
              value: notificationsEnabled, // Replace with actual value to manage the switch state
              onChanged: (bool value) async {
                if (!Platform.isMacOS) {
                  await Permission.notification.request();
                  if (await Permission.notification.request().isGranted) {
                    setState(() {
                    notificationsEnabled = true;
                  });
                  }
                  
                }
                else {
                  return;
                }
                
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('Account Settings',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.brush),
            title:
                Text('Colors', style: Theme.of(context).textTheme.bodyMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Language',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to language settings screen here
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text('Security',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to security settings screen here
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text('Help & Support',
                style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to help & support screen here
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title:
                Text('About', style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to about screen here
            },
          ),
        ],
      ),
    );
  }
}
