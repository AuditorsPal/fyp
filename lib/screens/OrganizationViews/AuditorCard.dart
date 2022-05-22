import 'package:auditorpal/Colors.dart';
import 'package:auditorpal/model/userModel.dart';
import 'package:auditorpal/screens/OrganizationViews/auditor_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import '../UserCheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import '../../controlller/readService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Auditor_list extends StatefulWidget {
  const Auditor_list({Key? key}) : super(key: key);

  @override
  _Auditor_listState createState() => _Auditor_listState();
}

class _Auditor_listState extends State<Auditor_list> {
  @override
  late final Stream<QuerySnapshot>? auditors;
  @override
  void initState() {
    // TODO: implement initState

    auditors = ReadService.readAllAuditors();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: StreamBuilder<QuerySnapshot> (stream: auditors,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong",
              style: const TextStyle(fontSize: 20),);
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
                            itemBuilder: (_, __) =>
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
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
                            itemCount: 2,
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
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white70,
                  margin: EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Container(
                    height: 275,
                    width: 300,
                    margin: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                        ),
                        SizedBox(height: 10,),
                        Text(data.docs[index]['name'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),),
                        SizedBox(height: 10,),
                        Text("Experience: " + data.docs[index]['experience'],
                        style: TextStyle(
                          fontSize: 14,
                        ),),
                        SizedBox(height: 15,),
                      RatingBar.builder(
                        initialRating: double.parse(data.docs[index]["rating"]),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                        SizedBox(height: 15,),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                   AuditorDetail(auditor_id:  data.docs[index].id)));
                          },

                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.black, width: 2,)
                              )
                          ),
                          child: Text("View Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),),
                        )

                      ],
                    ),

                  ),
                );
              });
        },

      ),
    );
  }
}

