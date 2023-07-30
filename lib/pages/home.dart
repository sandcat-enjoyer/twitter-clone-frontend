import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';
import 'package:twitter_clone/pages/firstSignin.dart';
import 'package:twitter_clone/pages/newTweet.dart';
import 'package:twitter_clone/pages/notifications.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/pages/userProfile.dart';
import 'package:twitter_clone/widgets/post.dart';

import '../data/tweet.dart';

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

  static List<Widget> getWidgetOptions(BuildContext context) {
    return [
      ListView(
        children: [
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2,
              imageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg")),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
          Post(Tweet(
              displayName: "jules ! :3",
              username: "@sandcat_enjoyer",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
              timeOfTweet: DateTime.now(),
              postText: "Haha BUSINESS",
              likes: 10,
              retweets: 2)),
        ],
      ),
      Text(
        "Search haha",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Notifications(user: User()),
      Text(
        "Message Haha",
        style: Theme.of(context).textTheme.titleLarge,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
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

  Route _createRouteToNewTweet() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NewTweet(user: User()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return Transform.translate(
              offset: tween.animate(animation).value,
              child: Transform.scale(
                scale: animation.value,
                child: child,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/icon.png", width: 30),
        centerTitle: true,
      ),
      body: Center(
        child: getWidgetOptions(context).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "")
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        selectedItemColor: const Color.fromARGB(255, 88, 242, 226),
        onTap: _onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      ),
      drawer: buildProfileDrawer(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        elevation: 5,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (context) => NewTweet(user: User()));
        },
        backgroundColor: const Color.fromARGB(255, 88, 242, 226),
        child: const Icon(Icons.bolt, size: 48),
      ),
    );
  }

  Widget buildProfileDrawer() {
    double iconSize = 32.0;
    TextStyle profileDrawerTextStyle = const TextStyle(
        fontFamily: "SF Pro",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    return Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              otherAccountsPictures: const [
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfile(user: User())));
              },
            ),
            ListTile(
              leading: Icon(Icons.list, size: iconSize, color: Colors.white),
              title: Text(
                'Lists',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FirstSignIn()));
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
            const Divider(thickness: 0.2, color: Colors.grey),
            ListTile(
              leading:
                  Icon(Icons.settings, size: iconSize, color: Colors.white),
              title: Text(
                'Settings and Privacy',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Settings(user: User())));
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.help_outline, size: iconSize, color: Colors.white),
              title: Text(
                'Help Center',
                style: profileDrawerTextStyle,
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}
