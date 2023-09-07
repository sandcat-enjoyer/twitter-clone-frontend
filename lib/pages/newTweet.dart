import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spark/services/auth_service.dart';
import 'package:uuid/uuid.dart';

import '../data/user.dart';

class NewTweet extends StatefulWidget {
  const NewTweet({Key? key, required UserLocal user})
      : _user = user,
        super(key: key);

  final UserLocal _user;

  @override
  _NewTweetState createState() => _NewTweetState();
}

class _NewTweetState extends State<NewTweet> {
  final TextEditingController boltController = TextEditingController();
  bool _canSendBolt = false;
  bool isDarkMode = false;
  late List<CameraDescription> _cameras;
  final AuthService authService = AuthService();
  String mediaURL = "";

  File? _mediaFile;

  Future<void> _getMediaFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
      });
    }
    
  }

  Future<void> _getMediaFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadMedia() async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child("users/${widget._user.uid}/images/posts/");
      final UploadTask uploadTask = storageRef.putFile(_mediaFile!);

      if (_mediaFile == null) {
        return;
      }
      else {
        await uploadTask.whenComplete(() => print("Media was uploaded"));
        mediaURL = await FirebaseStorage.instance.ref("users/${widget._user.uid}/images/posts/").getDownloadURL();
        print("URL for media: $mediaURL");
      }
    }
    catch(e) {
      print("Error uploading media: $e");
    }
  }



  @override
  void initState() {
    super.initState();
    
    boltController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _canSendBolt = boltController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    boltController.dispose();
    super.dispose();
  }

  _checkTheme() {
    //deprecated method but we'll fix this later, not that important
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;

    if (isDarkMode) {
      return const Color.fromARGB(255, 44, 52, 61);
    } else {
      return const Color.fromARGB(255, 240, 244, 250);
    }
  }

  void _postBolt() async {
    String boltText = boltController.text;
    if (boltText.isNotEmpty) {
      try {
        if (_mediaFile != null) {
          await _uploadMedia();
        }
        
        DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(widget._user.uid);
        await FirebaseFirestore.instance.collection("posts").add({
          "content": boltText,
          "createdAt": FieldValue.serverTimestamp(),
          "user": userRef,
          "imageUrl": mediaURL,
          "likes": 0,
          "rebolts": 0,
          "likedBy": []
        });
        boltController.clear();
      }
      catch (e) {
        print("Error posting: $e");
      }
    }
    print("The BOLT is here : $boltText");
    Navigator.pop(context);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Row(
            children: [
              const Text(
        "Awesome! Your bolt was posted.",
        style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
      ),
      TextButton(child: const Text("View Bolt", style: TextStyle(
        fontFamily: "Poppins"
      )), onPressed: () {

      })
            ],
          ) ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          child: Material(      
          color: _checkTheme(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 0,
                        child: Text(
                          'Create Bolt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      const SizedBox(width: 160.0),
                      TextButton(
                          onPressed: _canSendBolt ? _postBolt : null,
                          child: Icon(
                            Icons.send_rounded,
                            color: _canSendBolt
                                ? const Color.fromARGB(255, 88, 242, 226)
                                : Colors.grey,
                            size: 36,
                          ))
                    ],
                  )),
              SingleChildScrollView(
                child: TextField(
                  controller: boltController,
                  autofocus: true,
                  maxLength: 350,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "What's striking you?",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(20.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_mediaFile != null) ...[
                Center(
                  child: Image.file(_mediaFile!, height: 200)
                )
              ],
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                
                children: [
                  TextButton(
                      onPressed: () {
                        _getMediaFromCamera();
                      },
                      child: const Icon(Icons.camera_alt_rounded, size: 28,
                          color: Color.fromARGB(255, 88, 242, 226))),
                  TextButton(
                      onPressed: () {
                        _getMediaFromGallery();
                      },
                      child: const Icon(Icons.photo_rounded, size: 28,
                          color: Color.fromARGB(255, 88, 242, 226))),
                  TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.gif_box_rounded, size: 28,
                          color: Color.fromARGB(255, 88, 242, 226)))
                ],
              ),
              )
              

              // Add other widgets as needed for composing the tweet
            ],
          )),
        ) 
      ) ;
  }
}
