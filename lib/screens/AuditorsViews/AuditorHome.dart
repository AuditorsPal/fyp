import 'package:auditorpal/Colors.dart';
import 'package:auditorpal/model/userModel.dart';
import 'package:auditorpal/screens/AuditorsViews/AllProjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import '../UserCheck.dart';
import 'AllProjects.dart';
import 'MyTickets.dart';
import 'package:auditorpal/widgets/bottomnav.dart';
import 'NavBar.dart';
import 'SearchPage.dart';

class AuditorHome extends StatefulWidget {
  const AuditorHome({Key? key}) : super(key: key);

  @override
  State<AuditorHome> createState() => _AuditorHomeState();
}

class _AuditorHomeState extends State<AuditorHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavBar(),

        appBar: AppBar(
          title: const Text("Auditor"),
          backgroundColor: Color.fromARGB(255, 38, 146, 173),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search)),
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                context.read<AuthenticationService>().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => userCheck()),
                    (_) => false);
              }
            }),
          ],
        ),
        body: BottomNavigation(),

        // const TabBarView(
        //   children: [
        //     AllAuditors(),
        //     MyTickets(),
        //   ],
        // ),
      ),
    );
  }
}
