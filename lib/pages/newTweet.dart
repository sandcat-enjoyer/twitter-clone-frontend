import 'package:flutter/material.dart';

import '../data/user.dart';

class NewTweet extends StatefulWidget {
  const NewTweet({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  _NewTweetState createState() => _NewTweetState();
}

class _NewTweetState extends State<NewTweet> {
  final TextEditingController boltController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    boltController.dispose();
    super.dispose();
  }

  void _postBolt() {
    String boltText = boltController.text;
    print("The BOLT is here : $boltText");
    Navigator.pop(context);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(
        "Awesome! Your bolt was posted.",
        style: TextStyle(fontFamily: "SF Pro", fontWeight: FontWeight.bold),
      )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.65, // Adjust the height as needed
      child: Material(
          color: Color.fromARGB(255, 44, 52, 61),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Center(
                        child: Text(
                          'Create Bolt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SF Pro",
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 200.0),
                      TextButton(
                          onPressed: _postBolt,
                          child: Icon(
                            Icons.send_rounded,
                            color: Color.fromARGB(255, 88, 242, 226),
                            size: 36,
                          ))
                    ],
                  )),
              SingleChildScrollView(
                child: TextField(
                  controller: boltController,
                  maxLength: 350,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "What's striking you?",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(20.0),
                    counterStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Icon(Icons.camera_alt_rounded,
                          color: Color.fromARGB(255, 88, 242, 226))),
                  TextButton(
                      onPressed: () {},
                      child: Icon(Icons.photo_rounded,
                          color: Color.fromARGB(255, 88, 242, 226))),
                  TextButton(
                      onPressed: () {},
                      child: Icon(Icons.gif_box_rounded,
                          color: Color.fromARGB(255, 88, 242, 226)))
                ],
              )

              // Add other widgets as needed for composing the tweet
            ],
          )),
    );
  }
}
