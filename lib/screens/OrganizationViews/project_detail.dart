import 'package:auditorpal/controlller/writeService.dart';
import 'package:auditorpal/screens/AuditorsViews/profile.dart';
import 'package:auditorpal/screens/OrganizationViews/projectupload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/Colors.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';
import 'package:table_calendar/table_calendar.dart';


class project_details extends StatefulWidget {
  @override
  State<project_details> createState() => _project_detailsState();
}

class _project_detailsState extends State<project_details> {
  late final project;
  String email = "";
  String id = "";
  bool isData = false;
  bool isProject = false;
String projId="";

  @override
  void initState() {
    email = Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();
  }

  getIdByEmail() async {
    id = await ReadService.getOrgIdByEmail(email);

    readProject();
  }

  readProject() async {
    project = await ReadService.getProjbyOrgID(id);
    if (project != null)
    {
      projId = await ReadService.getProjIDByOrgID(id);
      setState(() {
        isProject = true;
      });
    }
    setState(() {
      isData = true;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isData == false ? Center(child: CircularProgressIndicator()):
      isProject == false ? Center(child: Text("No project created!"),): ListView(children: [
        SizedBox(height: 25.0),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(project["title"], //Project Name
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Color.fromARGB(255, 38, 146, 173))),
        ),
        SizedBox(height: 25.0),
        const Divider(
          height: 15,
          thickness: 2,
          indent: 25,
          endIndent: 25,
          color: Colors.blueGrey,
        ),
        SizedBox(height: 25.0),
        Center(
          child: Text(
            'Project Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 38, 146, 173),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                project["details"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black)),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            'Budget',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 38, 146, 173)
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Center(
          child: Text(
            'Rs. '+ project["budget"],
            style: TextStyle(
                color: Colors.blueGrey, fontSize: 20.0),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            'Due Date',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 38, 146, 173)
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            project["date"],
            style: TextStyle(
                color: Colors.blueGrey, fontSize: 20.0),
          ),
        ),
        SizedBox(height: 10.0),

        TableCalendar(
            focusedDay: DateTime.now(), firstDay: DateTime.utc(2010, 10, 16), lastDay: DateTime.utc(2030, 3, 14)),

        SizedBox(height: 40.0),
        Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Select Payment Method',
                            style: GoogleFonts.mulish(
                                color: Color(0xff2D7567),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),


                          ElevatedButton.icon(
                            icon: Icon(Icons.download,
                              size: 24.0,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: const Size(300, 46),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40)),
                                textStyle:
                                const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            label: Text('Easypaisa',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: const Size(300, 46),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40)),
                                textStyle:
                                const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text('Jazzcash',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:  Color(0xff2D7567),
                                fixedSize: const Size(300, 56),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40)),
                                textStyle:
                                const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text('Pay',
                              style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Payment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: MyColors.blueColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.blueGrey,
                        width: 2,
                      )),
            ),
                ),


            ),
        SizedBox(height: 20.0),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              Loader.show(context,
                  progressIndicator:
                  CircularProgressIndicator());
              final response = await WriteService.deleteProject(projId);
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
                      'Project Deleted!'),
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
            child: Text(
              "Close Project",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: MyColors.blueColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 2,
              padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.blueGrey,
                    width: 2,
                  )),
            ),
          ),


        ),
        SizedBox(height: 40.0),

      ]),
    );
  }
}
