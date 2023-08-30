import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:flutter/material.dart";
import "package:spark/pages/firstSignin.dart";
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _animation;

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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstSignIn()));
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