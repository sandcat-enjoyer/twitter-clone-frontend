import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class EditProfile extends StatefulWidget {
  final UserLocal user;
  EditProfile(this.user);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  String _newDisplayName = "";
  final _displayNameController = TextEditingController();
  final _pronounsController = TextEditingController();
  final _bioController = TextEditingController();

  _checkIfProfileImageExists() {
    if (widget.user.profilePictureUrl == "") {
      return CircleAvatar(
        child: Text(widget.user.displayName.substring(0, 1).toUpperCase()),
      );
    }

    else {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.user.profilePictureUrl),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return _buildPopUpDialog(context);
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text("Edit profile"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Form(child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          //actions for changing header image

                        },
                        child: Image.network("https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500"),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          
                          children: [
                            SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                //actions for changing profile picture

                              },
                              child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/1692646588382916608/WXqlbVuf_400x400.jpg"),
                            ),
                            ),
                            SizedBox(height: 50),
                            TextFormField(
                              controller: _displayNameController,
                              decoration: InputDecoration(
                                labelText: "Display Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _pronounsController,
                              decoration: InputDecoration(
                                labelText: "Pronouns",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _bioController,
                              decoration: InputDecoration(
                                labelText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            ElevatedButton(onPressed: () {

                            }, child: Text("Save changes"))
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ));
      }
    });
  }
}

Widget _buildPopUpDialog(BuildContext context) {
  final _displayNameController = TextEditingController();
  final _pronounsController = TextEditingController();
  final _bioController = TextEditingController();

  String headerImageUrl =
      "https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500";
  String profileImageUrl =
      "https://pbs.twimg.com/profile_images/1692646588382916608/WXqlbVuf_400x400.jpg";
  String pronouns = "he/him";
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: EdgeInsets.all(16),
      //need to re-evaluate this based on device orientation but this works for now
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Icon(
                  Icons.cancel,
                  size: 36,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                width: 100,
              ),
              ElevatedButton(
                style: ButtonStyle(),
                child: Text("Save"),
                onPressed: () {
                  //actions for saving the new changes to the profile
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Divider(),
          Form(
              child: Stack(
            children: [
              Image.network(
                headerImageUrl,
                height:
                    200, // Set the height of the header image as per your requirement
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: _displayNameController,
                      decoration: InputDecoration(
                          labelText: "Display Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _pronounsController,
                      decoration: InputDecoration(
                          labelText: "Pronouns",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                          labelText: "Bio",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    ),
  );
}
