import "dart:io";

import "package:flutter/material.dart";
import "package:permission_handler/permission_handler.dart";
import "package:spark/pages/settingsPages/accountSettings.dart";
import "package:spark/pages/settingsPages/colors.dart";
import "package:spark/pages/settingsPages/securityPage.dart";
import "package:spark/pages/splash.dart";
import "package:spark/services/auth_service.dart";

import "../data/user.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required UserLocal user})
      : _user = user,
        super(key: key);

  final UserLocal _user;

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
            leading: Icon(Icons.notifications, color: Theme.of(context).primaryIconTheme.color ),
            title: Text('Notifications',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Switch(
              value: notificationsEnabled, // Replace with actual value to manage the switch state
              onChanged: (bool value) async {
                if (!Platform.isMacOS) {
                  print("aheehee");
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
            leading: Icon(Icons.person, color: Theme.of(context).primaryIconTheme.color),
            title: Text('Account Settings',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color,),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountSettings(widget._user)));
            },
          ),
          ListTile(
            leading: Icon(Icons.brush, color: Theme.of(context).primaryIconTheme.color),
            title:
                Text('Colors', style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ColorsPage(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio))));

            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: Theme.of(context).primaryIconTheme.color),
            title: Text('Language',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color),
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text("Language picker"),
                  content: const Text("Available soon."),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: const Text("Close"))
                  ],
                );
              });
              // Navigate to language settings screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.security, color: Theme.of(context).primaryIconTheme.color),
            title: Text('Security',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color),
            onTap: () {
              // Navigate to security settings screen here
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecurityPage(widget._user)));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.help, color: Theme.of(context).primaryIconTheme.color),
            title: Text('Help & Support',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color),
            onTap: () {
              // Navigate to help & support screen here
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text("Help & Support"),
                  content: const Text("Moderation tools and other useful stuff coming later."),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();

                    }, child: const Text("Close"))
                  ],
                );
              });
            },
          ),
          
          ListTile(
            leading: Icon(Icons.info, color: Theme.of(context).primaryIconTheme.color),
            title:
                Text('About', style: Theme.of(context).textTheme.bodyMedium, ),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryIconTheme.color),
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text("About Spark"),
                  content: SizedBox(
                    height: 200,
                    child:Column(
                    children: [
                      Image.asset("assets/icon.png", width: 100,),
                      const SizedBox(height: 50),        
                      Text("Closed Beta 1", style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  ), 
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);

                    }, child: const Text("OK"))
                  ],
                );
              },);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.red),
            title: Text('Log Out',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
            onTap: () async {
              await AuthService().signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Splash()));
            },
          ),
        ],
      ),
    );
  }
}
