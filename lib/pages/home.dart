import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spark/data/navigationbloc.dart';
import 'package:spark/data/user.dart';
import 'package:spark/pages/firstSignin.dart';
import 'package:spark/pages/newTweet.dart';
import 'package:spark/pages/notifications.dart';
import 'package:spark/pages/post_detail.dart';
import 'package:spark/pages/register.dart';
import 'package:spark/pages/settings.dart';
import 'package:spark/pages/splash.dart';
import 'package:spark/pages/userProfile.dart';
import 'package:spark/widgets/post.dart';
import 'package:spark/widgets/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../data/tweet.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required UserLocal user})
      : _user = user,
        super(key: key);

  final UserLocal _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isDarkMode = false;
  dynamic posts;
  late AnimationController controller;
  Timestamp? timestamp;

  //late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    //controller =
    //    AnimationController(vsync: this, duration: const Duration(seconds: 1))
    //      ..forward()
    //      ..repeat();
    //animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose;
  }

  Future<void> fetchPosts() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("posts").orderBy("createdAt", descending: true).get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        snapshot.docs;

    documents.forEach((document) {
      print("Document ID: ${document.id}");
      print("Document data: ${document.data()}");
      setState(() {
        posts = document.data();
      });
    });
  }

  List<Widget> getWidgetOptions(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 600) {
      //tablet layout
      return [
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("posts").orderBy("createdAt", descending: true).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data();

                  //grab the user reference
                  DocumentReference userRef = data["user"] as DocumentReference;

                  return FutureBuilder(
                    future: userRef.get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container();
                      } else if (userSnapshot.hasError) {
                        return Text("Error: ${userSnapshot.error}");
                      } else {
                        Map<String, dynamic> userData =
                            userSnapshot.data!.data() as Map<String, dynamic>;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PostDetail(
                                    user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio,),
                                    postId: snapshot.data!.docs[index].id)));
                          },
                          child: Post(Tweet(
                              id: snapshot.data!.docs[index].id,
                              displayName: userData["displayname"],
                              username: userData["username"],
                              postText: data['content'],
                              likes: data["likes"],
                              retweets: data["rebolts"],
                              imageUrl: data["imageUrl"] ?? "",
                              timeOfTweet: data["createdAt"],
                              userProfileImageUrl:
                                  userData["profilePictureUrl"])),
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
        Text(
          "Search haha",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Notifications(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio, )),
        Text(
          "Message Haha",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        UserProfile(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio, )),
        SettingsPage(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio,))
      ];
    } else {
      //phone layout
      return [
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("posts").orderBy("createdAt", descending: true).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data();

                  //grab the user reference
                  DocumentReference userRef = data["user"] as DocumentReference;

                  return FutureBuilder(
                    future: userRef.get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container();
                      } else if (userSnapshot.hasError) {
                        return Text("Error: ${userSnapshot.error}");
                      } else {
                        Map<String, dynamic> userData =
                            userSnapshot.data!.data() as Map<String, dynamic>;
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostDetail(
                                      user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio),
                                      postId: snapshot.data!.docs[index].id)));
                            },
                            child: Post(Tweet(
                              id: snapshot.data!.docs[index].id,
                              displayName: userData["displayname"],
                              username: userData["username"],
                              postText: data['content'],
                              imageUrl: data["imageUrl"] ?? "",
                              likes: data["likes"],
                              retweets: data["rebolts"],
                              timeOfTweet: data["createdAt"],
                              userProfileImageUrl:
                                  userData["profilePictureUrl"],
                            )));
                      }
                    },
                  );
                },
              );
            }
          },
        ),
        Text(
          "Search haha",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Notifications(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio)),
        Text(
          "Message Haha",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        UserProfile(user: widget._user),
        SettingsPage(user: widget._user)
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

    final sheet = NewTweet(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio));

    const curve = Curves
        .fastEaseInToSlowEaseOut; // You can experiment with different curves here

    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: curve);

    animationController.forward();

    showModalBottomSheet(
      context: context,
      isDismissible: true,
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
    if (MediaQuery.of(context).size.width >= 600) {
      return;
    } else {
      return BottomNavigationBar(
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
        selectedItemColor: const Color.fromARGB(255, 88, 242, 226),
        onTap: _onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      );
    }
  }

  _determineIfDrawerIsNecessary() {
    if (MediaQuery.of(context).size.width >= 600) {
      return null;
    } else {
      return buildProfileDrawer();
    }
  }

  _determineIfAppBarIsNecessary() {
    if (MediaQuery.of(context).size.width >= 600) {
      return null;
    } else {
      return AppBar(
        title: Image.asset(
          "assets/icon.png",
          width: 40,
        ),
        centerTitle: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _determineIfAppBarIsNecessary(),
      body: RefreshIndicator(
          onRefresh: fetchPosts,
          child: Row(
            children: [
              if (MediaQuery.of(context).size.width >= 600) ...[
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return Sidebar(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      user: widget._user,
                    );
                  } else {
                    return buildProfileDrawer();
                  }
                })
              ],
              Expanded(
                  child: Center(
                child: getWidgetOptions(context).elementAt(_selectedIndex),
              ))
            ],
          ) /* FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("posts").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data();

                  //grab the user reference
                  DocumentReference userRef = data["user"] as DocumentReference;

                  return FutureBuilder(
                    future: userRef.get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      else if (userSnapshot.hasError) {
                        return Text("Error: ${userSnapshot.error}");
                      }
                      else {
                        Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
                        return Post(Tweet(
                    displayName: userData["displayname"],
                    username: userData["username"],
                    postText: data['content'],
                    likes: data["likes"],
                    retweets: data["rebolts"],
                    timeOfTweet: DateTime.now(),
                    userProfileImageUrl: "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg",
                  ));
                      }
                    },
                  ); 
                });
            }
          },
        ) */

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

  
  checkIfProfileImageExistsForDrawer() {
    if (widget._user.profilePictureUrl == "") {
      return CircleAvatar(
        maxRadius: 20,
        child: Text(widget._user.username.substring(0, 1).toUpperCase()),
      );
    }
    else {
      return CircleAvatar(
        maxRadius: 20,
        backgroundImage: NetworkImage(widget._user.profilePictureUrl),
      );
    }
  }

  Widget buildProfileDrawer() {
    double iconSize = 32.0;
    TextStyle profileDrawerTextStyle = const TextStyle(
        fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w500);
    return Drawer(
        backgroundColor: _checkTheme(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: _checkTheme(),
              ),
              accountName: Text(
                widget._user.displayName,
                style: TextStyle(
                    color: _checkThemeForText(),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                widget._user.username,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: _checkThemeForText(),
                    fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: checkIfProfileImageExistsForDrawer()
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
                    builder: (context) => UserProfile(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio))));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash()));
              },
            ),
            const Divider(thickness: 0.2, color: Colors.grey),
            ListTile(
              leading: Icon(Icons.settings,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
              title: Text(
                'Settings',
                style: profileDrawerTextStyle,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsPage(user: UserLocal(uid: widget._user.uid, pronouns: widget._user.pronouns, headerUrl: widget._user.headerUrl, displayName: widget._user.displayName, username: widget._user.username, profilePictureUrl: widget._user.profilePictureUrl, bio: widget._user.bio))));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline,
                  size: iconSize,
                  color: Theme.of(context).primaryIconTheme.color),
              title: Text(
                'Help & FAQ',
                style: profileDrawerTextStyle,
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}
