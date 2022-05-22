import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:auditorpal/controlller/authenticationService.dart';
import 'package:auditorpal/controlller/writeService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import '../../Colors.dart';
import '../login.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class ProjectUpload extends StatefulWidget {
  final org_id;
  const ProjectUpload({Key? key, required this.org_id}) : super(key: key);

  @override
  _ProjectUploadState createState() => _ProjectUploadState();
}

class _ProjectUploadState extends State<ProjectUpload> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  String date = '';
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 35, top: 30),
                      child: Text(
                        'Upload\Project',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: " Email Address",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: titleController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Project Title",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: detailsController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Project Details",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: budgetController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Budget",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          DateTimeFormField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Due Date',
                              labelStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              //print(value);

                              date =
                                  DateFormat("dd-MM-yyyy").format(value);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  String? response;
                                  response =
                                      await WriteService.createProject(
                                        email: emailController.text.trim(),
                                      title: titleController.text.trim(),
                                  details: detailsController.text.trim(),
                                  date:
                                  date,
                                  budget:
                                  budgetController.text
                                      .trim(),
                                  orgID: widget.org_id,
                                      auditorID: "");


                                  if (response == '1') {
                                    Navigator.pop(
                                        context, 'Project Created');
                                  } else {
                                    MotionToast.error(
                                      title: const Text(
                                        'Error',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      description: const Text(
                                          'Something went wrong'),
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
                                  "Upload Project",
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
