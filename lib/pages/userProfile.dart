import "package:flutter/material.dart";

import "../data/user.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username = "jules ! :3";
  String bio = "he/him 🏳️‍🌈 | microplastics connoisseur | 7ongcatUnbanned 💘";
  String profileImageUrl =
      "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg";
  String headerImageUrl =
      "https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500";

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
        title: Text(
          'User Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            headerImageUrl,
            height:
                200, // Set the height of the header image as per your requirement
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height:
                        100), // Adjust the height to make space for the header image
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      SizedBox(height: 16.0),
                      Text(username,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 8.0),
                      Text(
                        bio,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text("332 Followers", style: Theme.of(context).textTheme.bodyMedium,),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit, 
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8.0),
                            Text(
                              "Edit Profile",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)))),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Posts will go here',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
