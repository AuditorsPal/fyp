import 'dart:async';
import 'package:flutter/material.dart';

import 'UserCheck.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  startTime() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => userCheck()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
       
          Center(
            child:  Container(
              
              child: Image.asset('assets/images/AuditorsPal.png',    height: 380,    width: 250,)
              ),
          )
        ],
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     context.read<AuthenticationService>().signOut();
//     if (firebaseUser != null) {
//       print(firebaseUser);
//       return UserHome();
//     }
//     return userCheck();
//   }
// }
