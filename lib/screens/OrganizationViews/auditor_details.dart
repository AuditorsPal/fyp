import 'package:auditorpal/controlller/writeService.dart';
import 'package:auditorpal/screens/OrganizationViews/organizerChatHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';

class AuditorDetail extends StatefulWidget {
  final  auditor_id;
  const AuditorDetail({Key? key, required this.auditor_id}) : super(key: key);

  @override
  _AuditorDetailState createState() => _AuditorDetailState();
}

class _AuditorDetailState extends State<AuditorDetail> {
  late final profile;
  bool isData=false;
  String email = "";
  String id="";
  @override
  void initState() {
    email = Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();
  }

  getIdByEmail() async{
    id=await ReadService.getOrgIdByEmail(email);
    readProfile();
  }
  readProfile() async{
    profile=await ReadService.readProfile(widget.auditor_id);
    setState(() {
      isData=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
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
                    height: 35.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () {


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizerChatHome(otherUserID: widget.auditor_id, currentUserID: id, email: email)
                            ));
                      },
                        child: Text("Chat",
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
                      SizedBox(width: 20,),
                      ElevatedButton(onPressed: () async {
                        Loader.show(context,
                            progressIndicator:
                            CircularProgressIndicator());
                        String project_id = await ReadService.getProjIDByOrgID(id);
                        final response = await WriteService.hireAuditor(project_id, widget.auditor_id);
                        if (response == "1") {
                          Loader.hide();
                          MotionToast.success(

                            title: const Text(
                              'Success',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            description: const Text(
                                'Auditor Hired!'),
                            animationType: ANIMATION.fromLeft,
                            position: MOTION_TOAST_POSITION.top,
                            barrierColor:
                            Colors.black.withOpacity(0.3),
                            width: 300,
                            dismissable: true,
                          ).show(context);
                        } else {
                          Loader.hide();

                          MotionToast.error(
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            description: const Text(
                                'Something went wrong!'),
                            animationType: ANIMATION.fromLeft,
                            position: MOTION_TOAST_POSITION.top,
                            barrierColor:
                            Colors.black.withOpacity(0.3),
                            width: 300,
                            dismissable: true,
                          ).show(context);
                        }

                      },
                        child: Text("Hire Auditor",
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
                    ],
                  ),

                  SizedBox(height: 20,),
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
                          title: Text("No. of projects"),
                          subtitle: Text(profile["number_of_projects"]),
                          leading: Icon(
                            Icons.link,
                            color: Colors.deepPurple,
                          ),
                        ),
                        ListTile(
                          title: Text("Total Earnings"),
                          subtitle:
                          Text("Rs. " + profile["total_earning"]),
                          leading: Icon(
                            Icons.person,
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
