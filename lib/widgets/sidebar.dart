
import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final UserLocal user;

  Sidebar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected,
      required this.user});

  @override
  _SidebarState createState() => _SidebarState();
}

_checkIfExtendedIsNeeded(BuildContext context) {
  if (MediaQuery.of(context).size.width >= 900) {
    return true;
  } else {
    return false;
  }
}





class _SidebarState extends State<Sidebar> {

  _checkIfProfileImagePresent() {
  if (widget.user.profilePictureUrl == "") {
    return CircleAvatar(
      radius: 25,
      child: Text(widget.user.username.substring(0,1).toUpperCase()),
    );
  }
  else {
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(widget.user.profilePictureUrl),
    );
  }


  
}

  _showProfileNameWhenNeeded(BuildContext context) {
  if (MediaQuery.of(context).size.width <= 900 &&
      MediaQuery.of(context).size.width >= 600) {
    return Container();
  } else {
    return Container(
      child: Row(
        children: [const SizedBox(width: 25), Text(widget.user.displayName)],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: NavigationRail(
              groupAlignment: -0.9,
              selectedIconTheme: Theme.of(context).primaryIconTheme,
              extended: _checkIfExtendedIsNeeded(context),
              leading: IconButton(
                icon: Image.asset("assets/icon.png"),
                iconSize: 40,
                onPressed: () {
                  setState(() {
                    widget.onDestinationSelected(0);
                  });
                },
              ),
              trailing: Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(0, 0, 0, 0),
                            items: [
                              PopupMenuItem(
                                  child: Text(
                                "Test",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ))
                            ]);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _checkIfProfileImagePresent(),
                                  _showProfileNameWhenNeeded(context)
                                ],
                              ),
                            ],
                          )),
                    )),
              ),
              elevation: 5,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(
                      Icons.home_rounded,
                      size: 32,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    selectedIcon: Icon(
                      Icons.home_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
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
                    selectedIcon: Icon(
                      Icons.search_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
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
                    selectedIcon: Icon(
                      Icons.notifications_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
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
                    selectedIcon: Icon(
                      Icons.mail_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
                    label: Text(
                      "Messages",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.person_rounded,
                      size: 32,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    selectedIcon: Icon(
                      Icons.person_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
                    label: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.settings_rounded,
                      size: 32,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    selectedIcon: Icon(
                      Icons.settings_rounded,
                      color: Color.fromARGB(255, 0, 200, 226),
                      size: 32,
                    ),
                    label: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
              ],
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected),
        ));
  }
}
