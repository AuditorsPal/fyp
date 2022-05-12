import 'package:auditorpal/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerHome extends StatefulWidget {
  const OrganizerHome({ Key? key }) : super(key: key);

  @override
  State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Org")),
      body: Container(
        child: Text(Provider.of<UserModel>(context,listen:false).email),
      ),
    );
  }
}