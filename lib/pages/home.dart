
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:twitter_clone/data/user.dart';
import 'package:twitter_clone/pages/firstSignin.dart';
import 'package:twitter_clone/pages/newTweet.dart';
import 'package:twitter_clone/pages/notifications.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/pages/userProfile.dart';
import 'package:twitter_clone/widgets/post.dart';
import 'package:twitter_clone/widgets/sidebar.dart';

import '../data/tweet.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isDarkMode = false;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward()
          ..repeat();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose;
  }

  static List<Widget> getWidgetOptions(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 600) {
      //tablet layout
      return [
        ListView(
          children: [
            const SizedBox(height: 40),
            Post(Tweet(
              displayName: "pizza cat/ Longcat. - 2%",
              username: "@7ongcatUnbanned",
              userProfileImageUrl:
                  "https://pbs.twimg.com/profile_images/1667776665768869888/Vqf4ewyl_400x400.jpg",
              timeOfTweet: DateTime.now(),
              imageUrl:
                  "https://cdn.discordapp.com/attachments/810642958972878848/1138206895719600280/34by2d63j8g81.png",
              postText:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pharetra orci id quam posuere, id convallis ligula convallis. Nulla ut tellus consectetur, venenatis arcu nec, molestie ante. Curabitur sit amet malesuada libero. Aliquam erat volutpat. Cras hendrerit dapibus justo, sit amet consectetur sapien dapibus at. Nulla commodo velit nisi, nec fermentum diam feugiat eu. Vestibulum felis donec.",
              likes: 30000,
              retweets: 100000,
            )),
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
                postText:
                    "Haha BUSINESS fomfidhgbisogufdjosghufjpuibhjkgioshiujklgfbhfnfbhndfsjbhnlfdjgbhiogfjnkldjnkldndonldjsonlojpiknsgophjklnodpikns,pokghjiksfophjfklsojnlsgjnf,gsjnjlfjoshiknslopfkohifsdhu",
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
    } else {
      //phone layout
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
                postText:
                    "Haha BUSINESS fomfidhgbisogufdjosghufjpuibhjkgioshiujklgfbhfnfbhndfsjbhnlfdjgbhiogfjnkldjnkldndonldjsonlojpiknsgophjklnodpikns,pokghjiksfophjfklsojnlsgjnf,gsjnjlfjoshiknslopfkohifsdhu",
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _checkTheme() {
    //deprecated method but we'll fix this later, not that important
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;

    if (isDarkMode) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  _checkThemeForText() {
    // don't really know if there's a cleaner way to do this, i hope there is though
    return isDarkMode ? Colors.white : Colors.black;
  }

  void _showCustomModalBottomSheet(BuildContext context) {
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 500),
    );

    final sheet = NewTweet(user: User());

    const curve = Curves
        .fastEaseInToSlowEaseOut; // You can experiment with different curves here

    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: curve);

    animationController.forward();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => Transform.translate(
              offset: Offset(
                  0.0,
                  (1 - curvedAnimation.value) *
                      MediaQuery.of(context).size.height),
              child: child,
            ),
            child: sheet,
          ),
        );
      },
    );
  }

  _determineIfBottomNavBarNeeded(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 900) {
      return;
    } else {
      return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_home, progress: animation),
              label: ""),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "")
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        selectedItemColor: const Color.fromARGB(255, 88, 242, 226),
        onTap: _onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      );
    }
  }

  _determineIfDrawerIsNecessary() {
    if (MediaQuery.of(context).size.width >= 600) {
      return;
    } else {
      return buildProfileDrawer();
    }
  }

  _determineIfAppBarIsNecessary() {
    if (MediaQuery.of(context).size.width >= 600) {
      return;
    } else {
      return AppBar(
        title: Image.asset("assets/icon.png"),
        centerTitle: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _determineIfAppBarIsNecessary(),
      body: Row(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 600) {
              return Sidebar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            } else {
              return buildProfileDrawer();
            }
          }),
          Expanded(
            child: Center(
                child: getWidgetOptions(context).elementAt(_selectedIndex)),
          )
        ],
      ),
      bottomNavigationBar: _determineIfBottomNavBarNeeded(context),
      drawer: _determineIfDrawerIsNecessary(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 5,
        onPressed: () {
          _showCustomModalBottomSheet(context);
        },
        backgroundColor: const Color.fromARGB(255, 88, 242, 226),
        child: const Icon(Icons.bolt, size: 48),
      ),
    );
  }

  Widget buildProfileDrawer() {
    double iconSize = 32.0;
    TextStyle profileDrawerTextStyle = const TextStyle(
        fontFamily: "SF Pro", fontSize: 20, fontWeight: FontWeight.bold);
    return Drawer(
        backgroundColor: _checkTheme(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: _checkTheme(),
              ),
              otherAccountsPictures: const [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg"),
                )
              ],
              accountName: Text(
                "jules ! :3",
                style: TextStyle(
                    color: _checkThemeForText(),
                    fontFamily: "SF Pro",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "@sandcat_enjoyer",
                style: TextStyle(
                    fontFamily: "SF Pro", color: _checkThemeForText()),
              ),
              currentAccountPicture: const CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1667776269772046337/pUgHvR7W_400x400.jpg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
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
              leading: Icon(Icons.list,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
              title: Text(
                'Lists',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FirstSignIn()));
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
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
              leading: Icon(Icons.settings,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
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
              leading: Icon(Icons.help_outline,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
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
