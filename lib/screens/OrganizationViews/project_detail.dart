import 'package:auditorpal/screens/AuditorsViews/profile.dart';
import 'package:auditorpal/screens/OrganizationViews/projectupload.dart';
import 'package:flutter/material.dart';
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
  String proj_id = "";
  String id = "";
  bool isData = false;

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
    setState(() {
      isData = true;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isData == false ? Center(child: CircularProgressIndicator()): ListView(children: [
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
            child: Container(
                width: MediaQuery.of(context).size.width - 225.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color.fromARGB(255, 38, 146, 173),),
                child: Center(
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                ),

            ),

        ),
        SizedBox(height: 40.0),

      ]),
    );
  }
}
