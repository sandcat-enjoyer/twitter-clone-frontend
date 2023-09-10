import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';
import 'package:image_picker/image_picker.dart';
import "package:flutter_image_compress/flutter_image_compress.dart";


class EditProfile extends StatefulWidget {
  final UserLocal user;
  const EditProfile(this.user, {super.key});

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
    if (_imageFileProfile == null) {
      return;
    }
    else {
      try {
     Uint8List? compressedImageBytes = await FlutterImageCompress.compressWithFile(
        _imageFileProfile!.path,
        quality: 55
      );

      final Reference storageRef = FirebaseStorage.instance.ref().child("users/${widget.user.uid}/images/profile.jpg");
      final UploadTask uploadTask = storageRef.putData(compressedImageBytes!);
      if (_imageFileProfile == null) {
        return;
      }
      else {
        await uploadTask.whenComplete(() => print("Profile image was uploaded successfully"));
        profileURL = await FirebaseStorage.instance.ref("users/${widget.user.uid}/images/profile.jpg").getDownloadURL();
        print("URL for profile: $profileURL");
      }
    }

    catch(e) {
      print("Error uploading profile picture: $e");
    }
    }
  }

  

  Future<void> _uploadHeaderImage() async {
    try {
      Uint8List? compressedImageBytes = await FlutterImageCompress.compressWithFile(
        _imageFileHeader!.path,
        quality: 65
      );
      final Reference storageRef = FirebaseStorage.instance.ref().child("users/${widget.user.uid}/images/header.jpg");
      final UploadTask uploadTask = storageRef.putData(compressedImageBytes!);
      if (_imageFileHeader == null) {
        return;
      }
      else {
        await uploadTask.whenComplete(() => print("Image was uploaded successfully"));
        headerURL = await FirebaseStorage.instance.ref("users/${widget.user.uid}/images/header.jpg").getDownloadURL();
        print("URL for header: $headerURL");
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
    if (_imageFileProfile == null) {
      if (widget.user.profilePictureUrl == "") {
      return CircleAvatar(
        radius: 60,
        child: Text(widget.user.displayName.substring(0, 1).toUpperCase(), style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 55,
          fontWeight: FontWeight.bold
        ),),
      );
    }

    else {
      return CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(widget.user.profilePictureUrl),
      );
    }
    }
    else {
      return CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_imageFileProfile!)
      );

    }
    

  }

  _checkIfHeaderImageIsBeingChanged() {
    if (_imageFileHeader == null) {
      if (widget.user.headerUrl == null || widget.user.headerUrl == "") {
        return Container(
          height: 200,
        );
      }
      else {
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Image.network(widget.user.headerUrl!, fit: BoxFit.cover,)
        );
      }
    }
    else {
      //need to find a more proper way of scaling the image here
      return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Image.file(_imageFileHeader!, fit: BoxFit.cover,)
      );
    }
  }

  _fillValuesFromUser() {
    print(_bioController.text);
    if (_bioController.text == "" && widget.user.bio != "") {
      setState(() {
        _bioController.value = TextEditingValue(
          text: widget.user.bio!
        );
      });
      
    }

    if (_displayNameController.text == "" && widget.user.displayName != "") {
      setState(() {
        _displayNameController.value = TextEditingValue(
          text: widget.user.displayName
        );
      });
      
    }

    if (_pronounsController.text == "" && widget.user.pronouns != null && widget.user.pronouns != "") {
      setState(() {
        _pronounsController.value = TextEditingValue(
          text: widget.user.pronouns!
        );
      });
    }

    if (widget.user.profilePictureUrl != "") {
      profileURL = widget.user.profilePictureUrl;
    }

    if (widget.user.headerUrl != null && widget.user.headerUrl != "") {
      headerURL = widget.user.headerUrl!;
    }
  }

  @override 
  void initState() {
    _fillValuesFromUser();
    super.initState();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _displayNameController.dispose();
    _pronounsController.dispose();
    super.dispose();
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
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          
                          children: [
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                _getImageProfile();
                                //actions for changing profile picture

                              },
                              child: _checkIfProfileImageExists()
                            ),
                            const SizedBox(height: 80),
                            TextFormField(
                              controller: _displayNameController,
                              decoration: InputDecoration(
                                labelText: "Display Name",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _pronounsController,
                              decoration: InputDecoration(
                                labelText: "Pronouns",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _bioController,
                              decoration: InputDecoration(
                                labelText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                            const SizedBox(height: 50),
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

                            }, child: const Text("Save changes"))
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
  final displayNameController = TextEditingController();
  final pronounsController = TextEditingController();
  final bioController = TextEditingController();

  String headerImageUrl =
      "https://pbs.twimg.com/profile_banners/1201209148018434048/1665952533/1500x500";
  String profileImageUrl =
      "https://pbs.twimg.com/profile_images/1692646588382916608/WXqlbVuf_400x400.jpg";
  String pronouns = "he/him";
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(16),
      //need to re-evaluate this based on device orientation but this works for now
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Icon(
                  Icons.cancel,
                  size: 36,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(
                width: 100,
              ),
              ElevatedButton(
                style: const ButtonStyle(),
                child: const Text("Save"),
                onPressed: () {
                  //actions for saving the new changes to the profile
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Divider(),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: displayNameController,
                      decoration: InputDecoration(
                          labelText: "Display Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: pronounsController,
                      decoration: InputDecoration(
                          labelText: "Pronouns",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: bioController,
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
