import 'package:flutter/material.dart';
import 'package:auditorpal/controlller/readService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auditorpal/Colors.dart';

import '../../widgets/cards.dart';
import '../AuditorsViews/AllProjects.dart';
import 'Allprojs.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => DashBoard_State();
}

class DashBoard_State extends State<DashBoard> {
  late final Stream<QuerySnapshot>? events;
  @override
  void initState() {
    // TODO: implement initState

    events = ReadService.readAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Dashboard",
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 38, 146, 173),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 190,
                  child: Column(
                    children: [
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total\nProjects',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 38, 146, 173),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color.fromARGB(255, 51, 158, 102),
                                size: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '20',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Column(
                    children: [
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total\nEarnings',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 38, 146, 173),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.attach_money,
                                color: Color.fromARGB(255, 51, 158, 102),
                                size: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '20,000',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Todays Bookings',
                      style: GoogleFonts.mulish(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 38, 146, 173),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text('Hello 2'),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            AppCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Upcoming Appointments',
                      style: GoogleFonts.mulish(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 38, 146, 173),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text('Hello 2'),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            AppCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Monthly Earnings',
                      style: GoogleFonts.mulish(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 38, 146, 173),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text('Hello 2'),
                  ]),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllProjs()));
              },
              child: Text(
                "Find Work",
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
                      ))),
            ),
          ],
        ),
      )),
    );
   
  }
}
