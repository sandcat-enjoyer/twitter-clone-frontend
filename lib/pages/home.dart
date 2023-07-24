import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';
import 'package:twitter_clone/pages/notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static TextStyle tempTextStyle = const TextStyle(
      fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white);

  void changeFontWithPlatform() {
    if (kIsWeb) {
      print("meow");
    } else if (Platform.isIOS || Platform.isMacOS) {
      tempTextStyle.fontFamily == "SF Pro";
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      "Welcome to Spark",
      style: tempTextStyle,
    ),
    Text("Search haha", style: tempTextStyle),
    Notifications(user: User()),
    Text("Message Haha", style: tempTextStyle)
  ];

  @override
  void initState() {
    super.initState();
    changeFontWithPlatform();
  }

  @override
  void dispose() {
    super.dispose;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData.dark().primaryColor,
        title: Image.asset("assets/icon.png", width: 30),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ""),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      ),
      drawer: buildProfileDrawer(),
    );
  }

  Widget buildProfileDrawer() {
    double iconSize = 32.0;
    TextStyle profileDrawerTextStyle = TextStyle(
        fontFamily: "SF Pro",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    return Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              otherAccountsPictures: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg"),
                )
              ],
              accountName: Text("jules ! :3", style: profileDrawerTextStyle),
              accountEmail: Text("@sandcat_enjoyer"),
              currentAccountPicture: CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1667776269772046337/pUgHvR7W_400x400.jpg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, size: iconSize, color: Colors.white),
              title: Text(
                'Profile',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                // Handle Profile tap
              },
            ),
            ListTile(
              leading: Icon(Icons.list, size: iconSize, color: Colors.white),
              title: Text(
                'Lists',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                // Handle Lists tap
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.bookmark, size: iconSize, color: Colors.white),
              title: Text(
                'Bookmarks',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                // Handle Bookmarks tap
              },
            ),
            Divider(thickness: 0.2, color: Colors.grey),
            ListTile(
              leading:
                  Icon(Icons.settings, size: iconSize, color: Colors.white),
              title: Text(
                'Settings and Privacy',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                // Handle Settings tap
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.help_outline, size: iconSize, color: Colors.white),
              title: Text(
                'Help Center',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                // Handle Help Center tap
              },
            ),
          ],
        ));
  }
}
