import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';
import 'package:image_picker/image_picker.dart';


class EditProfile extends StatefulWidget {
  final UserLocal user;
  EditProfile(this.user);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _pronounsController = TextEditingController();
  final _bioController = TextEditingController();
  File? _imageFileHeader;
  File? _imageFileProfile;
  String headerURL = "";
  String profileURL = "";

  Future<void> _getImageHeader() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFileHeader = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageProfile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFileProfile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfileImage() async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child("users/${widget.user.uid}/images/profile");
      final UploadTask uploadTask = storageRef.putFile(_imageFileProfile!);
      if (_imageFileProfile == null) {
        return;
      }
      else {
        await uploadTask.whenComplete(() => print("Profile image was uploaded successfully"));
        profileURL = await FirebaseStorage.instance.ref("users/${widget.user.uid}/images/profile").getDownloadURL();
        print("URL for profile: " + profileURL);
      }
    }

    catch(e) {
      print("Error uploading profile picture: $e");
    }
  }

  

  Future<void> _uploadHeaderImage() async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child("users/${widget.user.uid}/images/header");
      final UploadTask uploadTask = storageRef.putFile(_imageFileHeader!);
      if (_imageFileHeader == null) {
        return;
      }
      else {
        await uploadTask.whenComplete(() => print("Image was uploaded successfully"));
        headerURL = await FirebaseStorage.instance.ref("users/${widget.user.uid}/images/header").getDownloadURL();
        print("URL for header: " + headerURL);
      }
      
    }
    catch (e) {
      print("Error uploading: $e");
    }
  }

  // Future<void> _uploadProfileImage(File imageFile) async {
  //   try {
  //     final Reference storageRef = FirebaseStorage.instance.ref().child("images");
  //     final UploadTask uploadTask = storageRef.putFile(imageFile);
  //     await uploadTask.whenComplete(() => print("Image was uploaded successfully"));
  //   }
  //   catch (e) {
  //     print("Error uploading: $e");
  //   }
  // }

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

  _checkIfHeaderImageIsBeingChanged() {
    if (_imageFileHeader == null) {
      return Image.network("https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500");
    }
    else {
      //need to find a more proper way of scaling the image here
      return Image.file(_imageFileHeader!, height: MediaQuery.of(context).size.height * 0.2, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,);
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
              title: const Text("Edit profile"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Form(child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _getImageHeader();
                          //actions for changing header image

                        },
                        child:_checkIfHeaderImageIsBeingChanged(),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          
                          children: [
                            SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                _getImageProfile();
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
                            ElevatedButton(onPressed: () async {
                              await _uploadHeaderImage();
                              await _uploadProfileImage();
                              FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
                                "bio": _bioController.text,
                                "displayname": _displayNameController.text,
                                "pronouns": "he/him",
                                "email": FirebaseAuth.instance.currentUser!.email,
                                "profilePictureUrl": profileURL,
                                "headerImageUrl": headerURL,
                                "username": widget.user.username
                              });

                              Navigator.of(context).pop();

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
