import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const Sidebar({super.key, required this.selectedIndex, required this.onDestinationSelected});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: NavigationRail(
            groupAlignment: -0.9,
            leading: Image.asset("assets/icon.png", width: 40),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 32,
                  ),
                  label: Text(
                    "Home",
                    style: TextStyle(
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 32,
                  ),
                  label: Text(
                    "Search",
                    style: TextStyle(
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.notifications_rounded,
                    size: 32,
                  ),
                  label: Text(
                    "Notifications",
                    style: TextStyle(
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              NavigationRailDestination(
                  icon: Icon(
                    Icons.mail_rounded,
                    size: 32,
                  ),
                  label: Text(
                    "Messages",
                    style: TextStyle(
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ],
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected));
  }
}
