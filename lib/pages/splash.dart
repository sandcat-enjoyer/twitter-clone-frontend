import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:spark/data/user.dart";
import "package:spark/pages/firstSignin.dart";
import "package:spark/pages/home.dart";

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _animation;
  late UserLocal userLocal;

  Future<void> fetchData(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (documentSnapshot.exists) {
        final Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
        userLocal = UserLocal.fromMap(userData, uid);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(user: userLocal)));
      }
    }

    catch(e) {
      print("An error occurred: $e");
    }

  }

  @override 
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (FirebaseAuth.instance.currentUser != null) {
          print("User is logged in");
          fetchData(FirebaseAuth.instance.currentUser!.uid);        
          
        }
        else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FirstSignIn()));
        }
        
      }
    });
    _controller.forward();
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset("assets/icon.png", width: 200,),
        ),
      ),
    );
  }
}