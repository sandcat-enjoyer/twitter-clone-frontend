import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/login.dart';

class FirstSignIn extends StatefulWidget {
  const FirstSignIn({Key? key}) : super(key: key);

  _FirstSignInState createState() => _FirstSignInState();
}

class _FirstSignInState extends State<FirstSignIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(height: 250),
          Image.asset(
            "assets/icon.png",
            width: 200,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Welcome to Spark",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          TextButton(
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SF Pro",
                  color: Color.fromARGB(255, 88, 242, 226)),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Login()));
            },
          )
          /* ElevatedButton(
              onPressed: () {},
              child: Text("Sign In"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 88, 242, 226)),
                  minimumSize: MaterialStateProperty.all<Size>(Size(180, 50)),
                  )) */
        ],
      ),
    ));
  }
}
