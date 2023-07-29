import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';
import 'package:twitter_clone/pages/home.dart';

void main() {
  runApp(const MyApp());
}

ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //final Color tealMain = const Color.fromARGB(255, 88, 242, 226);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Clone',
      theme: ThemeData(
        colorScheme: colorScheme,
        brightness: Brightness.light,
        useMaterial3: true,
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Colors.white),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(foregroundColor: Colors.white),
        primaryColor: Color.fromARGB(255, 88, 242, 226),
        textTheme: const TextTheme(
            displayMedium:
                TextStyle(fontFamily: "SF Pro", fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "SF Pro",
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF14171A)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF14171A),
            unselectedIconTheme: IconThemeData(color: Colors.white)),

        primaryColor: Color.fromARGB(255, 0, 200, 226),

        scaffoldBackgroundColor: const Color(0xFF14171A),
        cardColor: const Color(0xFF1C2938),

        textTheme: const TextTheme(
            displayMedium: TextStyle(
                fontFamily: "SF Pro",
                fontWeight: FontWeight.bold,
                color: Colors.white),
            titleLarge: TextStyle(
                fontFamily: "SF Pro",
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
            bodySmall: TextStyle(color: Colors.white)),

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
    );
  }
}
