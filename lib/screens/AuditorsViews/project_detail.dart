import 'package:auditorpal/screens/AuditorsViews/progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Colors.dart';
import '../../controlller/readService.dart';
import '../../model/userModel.dart';

class project_detail extends StatefulWidget {
  final  project_id;
  const project_detail({Key? key, required this.project_id}) : super(key: key);
  @override
  State<project_detail> createState() => _project_detailState();
}

class _project_detailState extends State<project_detail> {
  late final project;
  bool isData=false;
  String email = "";
  String id="";
  @override
  void initState() {
    getId();

  }

  getId() async{
    id= widget.project_id;
    await readProfile();
  }
  readProfile() async{
    project=await ReadService.readProject(widget.project_id);
    setState(() {
      isData=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Details"),
        backgroundColor: Color.fromARGB(255, 38, 146, 173),
        centerTitle: true,
      ),
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

      ]),
    );
  }
}
