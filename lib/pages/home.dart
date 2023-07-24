import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required User user}) : _user = user, super(key: key);

  final User _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static TextStyle tempTextStyle = const TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white
  );

  static final List<Widget> _widgetOptions = <Widget>[
    Text("Home screen Haha", style: tempTextStyle,),
    Text("Search haha", style: tempTextStyle),
    Text("Notification Haha", style: tempTextStyle,),
    Text("Message Haha", style: tempTextStyle)
  ];

  @override 
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData.dark().primaryColor,
        title: Image.asset("assets/icon.png", width: 30),
        centerTitle: true,

      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ""),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      ),
      drawer: const Drawer(
        
      ),
     );
  }

  


}