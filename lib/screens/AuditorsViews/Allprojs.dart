import 'package:auditorpal/screens/AuditorsViews/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:auditorpal/controlller/readService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auditorpal/Colors.dart';

import '../../widgets/cards.dart';
import '../OrganizationViews/SearchPage.dart';

class AllProjs extends StatefulWidget {
  const AllProjs({Key? key}) : super(key: key);

  @override
  State<AllProjs> createState() => AllProjs_State();
}

class AllProjs_State extends State<AllProjs> {
  late final Stream<QuerySnapshot>? events;
  @override
  void initState() {
    // TODO: implement initState

    events = ReadService.readAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
          centerTitle: true,
          title: const Text("Auditor"),
          backgroundColor: Color.fromARGB(255, 38, 146, 173),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search)),

          ],
        ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: events,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "Something went wrong",
                    style: const TextStyle(fontSize: 20),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey,
                                enabled: true,
                                child: ListView.builder(
                                  itemBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 48.0,
                                          height: 48.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  itemCount: 6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }
    
                final data = snapshot.requireData;
                return ListView.builder(
                    itemCount: data.size,
                    // Text(data.docs[index]['name'])
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.white70,
                          margin: EdgeInsets.fromLTRB(30, 15, 30, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 200,
                            ),
                            width: 300,
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(data.docs[index]["title"],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),),
                                SizedBox(height: 10,),
                                Text(data.docs[index]["details"],
                                ),
                                SizedBox(height: 10,),
                                Text("Budget: Rs. " + data.docs[index]["budget"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
    
                                  ),),
                                SizedBox(height: 15,),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                project_detail(project_id:  data.docs[index].id)));
                                  },
    
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 0,
                                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          side: BorderSide(color: Colors.black,)
                                      )
                                  ),
                                  child: Text("Project details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ));
                    });
              })),
    );
  }}
