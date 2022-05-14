import 'package:auditorpal/Colors.dart';
import 'package:auditorpal/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import '../UserCheck.dart';

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
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Events"),
              Tab(text: "My Tickets"),
            ],
          ),
          title: const Text("User"),
          backgroundColor: MyColors.blueColor,
          actions: [
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
      ),
    );
  }
}
