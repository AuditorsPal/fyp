import 'package:auditorpal/screens/UserCheck.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controlller/readService.dart';
import '../../model/userModel.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import 'package:auditorpal/Colors.dart';
import 'org_profile.dart';
import 'org_profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final user;
  @override
  void initState() {
    user = Provider.of<UserModel>(context, listen: false).email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://www.teahub.io/photos/full/255-2555204_iphone-black-blur-background.jpg'),
              ),
            ),
            accountName: Text(""),
            accountEmail: Text('${user}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.redAccent,
              minRadius: 100.0,
              child: CircleAvatar(
                radius: 80.0,
                child: Text(
                  "${user[0]}",
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text('Settings'),
            onTap: () {
              //Update the state of the app.
              // Navigator.push(context,
              //   MaterialPageRoute(
              //       builder: (BuildContext context) => Settings()//StateInheritedWidget.of(context))
              //   ),);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        org_profile() //StateInheritedWidget.of(context))
                    ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout'),
            onTap: () async {
              context.read<AuthenticationService>().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => userCheck()),
                  (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
