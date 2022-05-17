import 'package:flutter/material.dart';
import 'package:auditorpal/controlller/readService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auditorpal/Colors.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({Key? key}) : super(key: key);

  @override
  State<AllProjects> createState() => AllProjects_State();
}

class AllProjects_State extends State<AllProjects> {
  late final Stream<QuerySnapshot>? events;
  @override
  void initState() {
    // TODO: implement initState

    events = ReadService.readAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              data.docs[index]['title'],
                              style: TextStyle(fontSize: 30),
                            ),
                  
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[],
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
