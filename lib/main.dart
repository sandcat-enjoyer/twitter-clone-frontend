import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';
import 'package:twitter_clone/pages/home.dart';

void main() {
  runApp(const MyApp());
}

ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Clone',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF14171A),
          unselectedIconTheme: IconThemeData(color: Colors.white)
        ),
        primaryColor: const Color(0xFF1DA1F2),
        primaryColorDark: const Color(0xFF1581D5),
        primaryColorLight: const Color(0xFF1DA1F2),

        scaffoldBackgroundColor: const Color(0xFF14171A),
        cardColor: const Color(0xFF1C2938),

        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            ),
          bodyMedium: TextStyle(
            color: Colors.white,
      ),
    ),

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

