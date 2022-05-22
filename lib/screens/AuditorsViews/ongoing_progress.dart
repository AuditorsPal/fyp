import 'package:auditorpal/controlller/writeService.dart';
import 'package:auditorpal/screens/OrganizationViews/organizerChatHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';

class ongoing_project extends StatefulWidget {

  const ongoing_project({Key? key}) : super(key: key);

  @override
  _ongoing_projectState createState() => _ongoing_projectState();
}

class _ongoing_projectState extends State<ongoing_project> {
  late final project;
  bool isData = false;
  bool isProject = false;
  String email = "";
  String auditor_id ="";
  @override
  void initState() {
    email = Provider.of<UserModel>(context, listen: false).email;
    getId();

  }
  getId() async{
    auditor_id = await ReadService.getIdByEventNameAndEmail(email);
    await readProfile();
  }
  readProfile() async{
    project = await ReadService.getProjbyAuditorID(auditor_id);
    if (project != null)
      {
        setState(() {
          isProject = true;
        });
      }
    setState(() {
      isData=true;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: isData == false ? Center(child: CircularProgressIndicator()):
      isProject == false ? Center(child: Text("No project assigned!"),): ListView(children: [
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

      ]),
    );
  }
}
