import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';

class org_profile extends StatefulWidget {
  @override
  State<org_profile> createState() => _org_profileState();
}

class _org_profileState extends State<org_profile> {
  late final org_profile;
  String email="";
  String id="";
  bool isData=false;
  @override
  void initState() {
    email=Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();


  }
  readProfile() async{
    org_profile = await ReadService.readOrgProfile(id);
    setState(() {
      isData=true;
    });
  }
  getIdByEmail() async{
    id=await ReadService.getOrgIdByEmail(email);
    readProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: isData == false ? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 215,
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
                          color: Colors.teal[800],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 100.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //Connect1
                                  Text(
                                    org_profile["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.0,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      "Country",
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
                          ],
                        ),
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: EdgeInsets.only(left: 17.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),

                  ElevatedButton(onPressed: () {},
                    child: Text("Edit Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blueGrey, width: 2,)
                        )
                    ),),
                  SizedBox(height: 20,),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(

                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 6,
                      ),],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Company Info",
                            style: TextStyle(
                              fontSize: 21.0,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text(org_profile["email"]),
                          leading: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(org_profile["phone_number"]),
                          leading: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle: Text(org_profile["address"]),
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                        ),
                        ListTile(
                          title: Text("Business Details"),
                          subtitle:
                              Text(org_profile["businessdetail"]),
                          leading: Icon(
                            Icons.business,
                            color: Colors.blue,
                          ),
                        ),
                        ListTile(
                          title: Text("NTN"),
                          subtitle: Text(org_profile["ntn"]),
                          leading: Icon(
                            Icons.numbers,
                            color: Colors.black,
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
