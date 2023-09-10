import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class SecurityPage extends StatefulWidget {
  final UserLocal user;
  const SecurityPage(this.user, {super.key});

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security")
      ),
      body: const Text("Security Page")
    );
  }
}