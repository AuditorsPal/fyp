import 'package:auditorpal/Colors.dart';
import 'package:auditorpal/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import '../UserCheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import '../../controlller/readService.dart';
import 'SearchPage.dart';
import 'BottonNavBar.dart';


class OrganizationHome extends StatefulWidget {
  const OrganizationHome({Key? key}) : super(key: key);

  @override
  _OrganizationHomeState createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization"),
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
      body: BottomNavBar(),
    );
  }
}