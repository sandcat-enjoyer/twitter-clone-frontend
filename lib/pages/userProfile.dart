import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:spark/pages/editProfile.dart";

import "../data/tweet.dart";
import "../data/user.dart";
import "../widgets/post.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required UserLocal user})
      : _user = user,
        super(key: key);

  final UserLocal _user;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  void _showCustomModalBottomSheet(BuildContext context) {
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 500),
    );

    final sheet = EditProfile(widget._user);

    const curve = Curves
        .fastEaseInToSlowEaseOut; // You can experiment with different curves here

    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: curve);

    animationController.forward();

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                  const SizedBox(
                      height:
                          100), // Adjust the height to make space for the header image
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage:
                              NetworkImage(widget._user.profilePictureUrl),
                        ),
                        const SizedBox(height: 16.0),
                        Text(widget._user.displayName,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4.0),
                        Text(widget._user.username),
                        const SizedBox(height: 8),
                        Text(pronouns,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8.0),
                        Text(
                          widget._user.bio ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_city_rounded),
                            const SizedBox(width: 8),
                            Text(
                              "Antwerp",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 60),
                            const Icon(Icons.link_rounded),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("Website Link")
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(
                              "Born February 7",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 40),
                            const Icon(Icons.calendar_month_outlined),
                            const SizedBox(width: 8),
                            const Text("Joined July 2023")
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
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (MediaQuery.of(context).size.width > 600) {
                              _showCustomModalBottomSheet(context);
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfile(widget._user)));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8.0)))),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
