import 'package:auditorpal/Colors.dart';
import 'package:auditorpal/model/userModel.dart';
import 'package:auditorpal/screens/AuditorsViews/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import '../UserCheck.dart';
import 'Dashboard.dart';
import 'package:auditorpal/widgets/bottomnav.dart';
import 'NavBaraud.dart';
import 'SearchPage.dart';

class AuditorHome extends StatefulWidget {
  const AuditorHome({Key? key}) : super(key: key);

  @override
  State<AuditorHome> createState() => _AuditorHomeState();
}

class _AuditorHomeState extends State<AuditorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),

        appBar: AppBar(
          centerTitle: true,
          title: Image.asset('assets/images/AuditorsPal2.png',fit:BoxFit.cover,
          height:160.00,
          width:160.00),
          backgroundColor: Color.fromARGB(255, 38, 146, 173),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search)),

          ],
        ),
        body: BottomNavigation(),

        // const TabBarView(
        //   children: [
        //     AllAuditors(),
        //     MyTickets(),
        //   ],
        // ),
      );
  }
}
