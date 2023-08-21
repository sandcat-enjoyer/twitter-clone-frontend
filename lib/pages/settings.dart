import "package:flutter/material.dart";

import "../data/user.dart";

class Settings extends StatefulWidget {
  const Settings({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
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
        title:
            Text('Settings', style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notifications',
                style: Theme.of(context).textTheme.titleMedium),
            trailing: Switch(
              value:
                  true, // Replace with actual value to manage the switch state
              onChanged: (bool value) {
                // Handle switch state change here
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('Account Settings',
                style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.brush),
            title:
                Text('Colors', style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Language',
                style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to language settings screen here
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text('Security',
                style: Theme.of(context).textTheme.titleMedium),
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
