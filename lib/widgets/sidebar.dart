import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const Sidebar({super.key, required this.selectedIndex, required this.onDestinationSelected});

  @override
  _SidebarState createState() => _SidebarState();
}

_checkIfExtendedIsNeeded(BuildContext context){
  if (MediaQuery.of(context).size.width >= 900) {
    return true;
  }
  else {
    return false;
  }
} 

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:NavigationRail(
            groupAlignment: -0.9,
            selectedIconTheme: Theme.of(context).primaryIconTheme,
            extended: _checkIfExtendedIsNeeded(context),
            leading: Image.asset("assets/icon.png", width: 40),
            destinations: [
              NavigationRailDestination(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 32,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  selectedIcon: Icon(Icons.home_rounded, color: Color.fromARGB(255, 0, 200, 226), size: 32,),
                  label: Text(
                    "Home",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 32,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  selectedIcon: Icon(Icons.search_rounded, color: Color.fromARGB(255, 0, 200, 226), size: 32,),
                  label: Text(
                    "Search",
                   style: Theme.of(context).textTheme.headlineSmall,
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.notifications_rounded,
                    size: 32,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  selectedIcon: Icon(Icons.notifications_rounded, color: Color.fromARGB(255, 0, 200, 226), size: 32,),
                  label: Text(
                    "Notifications",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.mail_rounded,
                    size: 32,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  selectedIcon: Icon(Icons.mail_rounded, color: Color.fromARGB(255, 0, 200, 226), size: 32,),
                  label: Text(
                    "Messages",
                   style: Theme.of(context).textTheme.headlineSmall,
                  )),
            ],
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected) ,
        ) );
  }
}
