import 'package:auditorpal/screens/OrganizationViews/org_profile.dart';
import 'package:auditorpal/screens/OrganizationViews/project_detail.dart';
import 'package:flutter/material.dart';
import 'AuditorCard.dart';
import 'org_profile.dart';
import 'organizeeAllChats.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Auditor_list(),
    OrgAllChats(),
    project_details(),
    org_profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
            Color.fromARGB(255, 38, 146, 173), // <-- This works for fixed
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Color.fromARGB(255, 0, 0, 0),

            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat,
                    color: Color.fromARGB(255, 0, 0, 0)),
                label: ('Chat'),
                // backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                icon:
                Icon(Icons.analytics, color: Color.fromARGB(255, 0, 0, 0)),
                label: 'Project',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box,
                    color: Color.fromARGB(255, 0, 0, 0)),
                label: 'My Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            // selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

