import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spark/data/post_provider.dart';
import 'package:spark/data/user.dart';
import 'package:spark/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /* if (Platform.isMacOS) {
    await WindowManipulator.initialize();
    WindowManipulator.hideTitle();
  } */
  //WindowManipulator.makeTitlebarTransparent();
  runApp(const MyApp());
}

_checkScreenWidth(BuildContext context) {
  if (MediaQuery.of(context).size.width >= 600) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //final Color tealMain = const Color.fromARGB(255, 88, 242, 226);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _checkScreenWidth(context);
    return ChangeNotifierProvider(create: (context) => PostsProvider(),
    child: MaterialApp(
      title: 'Spark',
      //Light Theme
      theme: ThemeData(
        colorScheme: colorScheme,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          elevation: 0
        ),
        scaffoldBackgroundColor: Colors.white,
        //Colors
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(foregroundColor: Colors.white),
        primaryColor: const Color.fromARGB(255, 88, 242, 226),
        iconTheme: const IconThemeData(color: Colors.black),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        //Fonts
        textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              
            ),
            displayMedium:
                TextStyle(fontFamily: "Poppins", 
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold),
            bodySmall:
                TextStyle(fontFamily: "Poppins", 
                fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 16,
                letterSpacing: 0.4
                ),
            bodyLarge: TextStyle(fontFamily: "Poppins", fontSize: 25),
            labelSmall: TextStyle(
                fontFamily: "Poppins",
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.blueGrey,
                letterSpacing: 1),
            labelLarge: TextStyle(fontFamily: "Poppins")),
      ),

      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF14171A)),
        hintColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF14171A),
            unselectedIconTheme: IconThemeData(color: Colors.white)),
        

        primaryColor: const Color.fromARGB(255, 0, 200, 226),

        scaffoldBackgroundColor: const Color(0xFF14171A),
        cardColor: const Color(0xFF1C2938),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),

        primaryIconTheme: const IconThemeData(color: Colors.white),

        textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
            displayMedium: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.white),
            titleLarge: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 16,
                letterSpacing: 0.4),
            bodyLarge: TextStyle(
                fontSize: 25, color: Colors.white, 
                fontFamily: "Poppins"),
            labelSmall: TextStyle(
                fontFamily: "Poppins",
                fontSize: 13,
                letterSpacing: 1,
                fontWeight: FontWeight.normal,
                color: Colors.grey),
            labelLarge: TextStyle(fontFamily: "Poppins", color: Colors.white)),

        // Icon Colors
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        // Button Colors
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF1DA1F2),
        ),

        // Divider Color
        dividerColor: Colors.grey,
      ),
      home: Home(user: User()),
    )); 
  }
}
