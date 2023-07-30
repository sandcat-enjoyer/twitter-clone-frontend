import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: "4K")
      ]),

      //Light Theme
      theme: ThemeData(
        colorScheme: colorScheme,
        brightness: Brightness.light,
        useMaterial3: true,
        //Colors
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(foregroundColor: Colors.white),
        primaryColor: const Color.fromARGB(255, 88, 242, 226),
        iconTheme: IconThemeData(color: Colors.black),
        primaryIconTheme: IconThemeData(color: Colors.black),

        //Fonts
        textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontFamily: "SF Pro",
              fontWeight: FontWeight.w600,
            ),
            displayMedium:
                TextStyle(fontFamily: "SF Pro", fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "SF Pro",
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold),
            bodySmall:
                TextStyle(fontFamily: "SF Pro", fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                color: Colors.black, fontFamily: "SF Pro", fontSize: 16),
            bodyLarge: TextStyle(fontFamily: "SF Pro"),
            labelSmall: TextStyle(
                fontFamily: "SF Pro",
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.blueGrey),
            labelLarge: TextStyle(fontFamily: "SF Pro")),
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF14171A)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF14171A),
            unselectedIconTheme: IconThemeData(color: Colors.white)),

        primaryColor: const Color.fromARGB(255, 0, 200, 226),

        scaffoldBackgroundColor: const Color(0xFF14171A),
        cardColor: const Color(0xFF1C2938),

        primaryIconTheme: IconThemeData(color: Colors.white),

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
            bodySmall: TextStyle(color: Colors.white),
            labelSmall: TextStyle(
                fontFamily: "SF Pro",
                fontWeight: FontWeight.normal,
                color: Colors.grey)),

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
