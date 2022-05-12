import 'package:auditorpal/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuditorHome extends StatefulWidget {
  const AuditorHome({ Key? key }) : super(key: key);

  @override
  State<AuditorHome> createState() => _AuditorHomeState();
}

class _AuditorHomeState extends State<AuditorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auditor")),
      body: Container(
        child: Text(Provider.of<UserModel>(context,listen:false).userType),
      ),
    );
  }
}