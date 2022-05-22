import 'package:auditorpal/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auditorpal/Colors.dart';

class userCheck extends StatelessWidget {
  String userType = "";
  userCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: MyColors.blueColor,
        fixedSize: const Size(200, 70),
        textStyle: TextStyle(fontSize: 20));
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login.png'),
                fit: BoxFit.cover),
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: style,
              onPressed: () {
                userType = "auditor";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyLogin(userType: userType)),
                );
              },
              child: const Text('Auditor Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: style,
              onPressed: () {
                userType = "organization";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyLogin(userType: userType)),
                );
              },
              child: const Text('Organizer Login'),
            ),
          ],
        ))
      ],
    );
  }
}
