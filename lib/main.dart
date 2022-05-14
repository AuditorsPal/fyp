import 'package:flutter/material.dart';
import 'package:auditorpal/screens/login.dart';
import 'package:auditorpal/screens/signup.dart';
import 'package:auditorpal/screens/resetpass.dart';
import 'package:auditorpal/screens/profile.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      title: 'OMS',
      routes: {
        'login': (context) => myLogin(),
        'register': (context) => myRegister(),
        'forgot': (context) => resetPassword(),
        'profile': (context) => profile(),
      },
    ),
  );
}
