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
  String bio = "🏳️‍🌈 | microplastics connoisseur | 7ongcatUnbanned 💘";
  String profileImageUrl =
      "https://pbs.twimg.com/profile_images/1678072904884318208/zEC1bBWi_400x400.jpg";
  String headerImageUrl =
      "https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500";
  String pronouns = "he/him";

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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.network(
                headerImageUrl,
                height:
                    200, // Set the height of the header image as per your requirement
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
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
                        SizedBox(height: 4.0),
                        Text(pronouns,
                            style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(height: 8.0),
                        Text(
                          bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_city_rounded),
                            SizedBox(width: 8),
                            Text(
                              "Antwerp",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 60),
                            const Icon(Icons.link_rounded),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Website Link")
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text(
                              "Born February 7",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 40),
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(width: 8),
                            Text("Joined July 2023")
                          ],
                        ),
                        /* Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_city_rounded),
                                    SizedBox(width: 8),
                                    Text(
                                      "Antwerp",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.link_rounded),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Website Link")
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.people_alt_rounded),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "332 Followers",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(width: 8),
                            Text("Joined July 2023")
                          ],)
                                  ],
                                )
                              ],
                            )
                          ],
                        ), */
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8.0)))),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8.0),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      fontFamily: "SF Pro",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Posts will go here',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
