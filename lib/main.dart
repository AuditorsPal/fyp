import 'package:flutter/material.dart';
import 'package:auditorpal/screens/login.dart';
import 'package:auditorpal/screens/signup.dart';
import 'package:auditorpal/screens/resetpass.dart';

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
      },
    ),
  );
}
