import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  late final profile;
  String email="";
  String id="";
  bool isData=false;
  @override
  void initState() {
    email=Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();


  }
  readProfile() async{
    profile=await ReadService.readProfile(id);
    setState(() {
      isData=true;
    });
  }
  getIdByEmail() async{
    id=await ReadService.getIdByEventNameAndEmail(email);
    readProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isData == false ? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[800])),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(
                          top: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[900],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //Connect1
                                  Text(
                                    profile["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.0,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      "Pakistan",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                //Stat 1
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      Text(profile["rating"] +
                                        "/5",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Stat 2
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Availability",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      Text(
                                        "No",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Stat 3
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Experience",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      Text(
                                        profile["experience"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        margin: EdgeInsets.only(left: 17.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 6,
                      ),],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "User Info",
                            style: TextStyle(
                              fontSize: 21.0,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text(profile["email"]),
                          leading: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(profile["phone_number"]),
                          leading: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                        ListTile(
                          title: Text("No. of Projects"),
                          subtitle: Text(profile["number_of_projects"]),
                          leading: Icon(
                            Icons.link,
                            color: Colors.deepPurple,
                          ),
                        ),
                        ListTile(
                          title: Text("Total Earning"),
                          subtitle:
                          Text("Rs. " + profile["total_earning"]),
                          leading: Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
