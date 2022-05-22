import 'package:flutter/material.dart';

class project_detail extends StatefulWidget {
  @override
  State<project_detail> createState() => _project_detailState();
}

class _project_detailState extends State<project_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 25.0),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text('AuditorsPal', //Project Name
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[600])),
        ),
        Center(
          child: Text('Gayroop', //Company Name
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[600])),
        ),
        SizedBox(height: 25.0),
        const Divider(
          height: 20,
          thickness: 5,
          indent: 25,
          endIndent: 25,
          color: Colors.grey,
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            'Budget',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Center(
          child: Text(
            '5 Tarzan',
            style: TextStyle(
                color: Color(0xFF575E67), fontFamily: 'Varela', fontSize: 24.0),
          ),
        ),
        SizedBox(height: 40.0),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                'The courageous fallen! The anguished fallen! Their lives have meaning because we the living refuse to forget them! And as we ride to certain death, we trust our successors to do the same for us! Because my soldiers do not buckle or yield when faced with the cruelty of this world!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Colors.grey[700])),
          ),
        ),
        SizedBox(height: 40.0),
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.teal[600]),
                child: Center(
                    child: Text(
                  'Payment',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))))
      ]),
    );
  }
}
