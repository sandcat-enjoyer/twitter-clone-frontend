import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({Key? key, required UserLocal user})
    : _user = user,
      super(key: key);
  
  final UserLocal _user;

  @override 
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {

  @override 
  void initState() {
    super.initState();
  }

  @override 
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Colors"),
      ),
      body: const Text("This is where custom colors will go")
    );
  }
}