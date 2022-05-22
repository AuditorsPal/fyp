import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:auditorpal/controlller/WriteService.dart';
import '../../Colors.dart';
import 'package:auditorpal/controlller/readService.dart';

import '../../model/userModel.dart';

class progress extends StatefulWidget {
  const progress({Key? key}) : super(key: key);

  @override
  State<progress> createState() => _progressState();
}

class _progressState extends State<progress> {
  String id = "";
  int _counter = 0;
  double progressvalue = 0;
  String value = "No progress";
  
  String email = "";
    void initState() {
    email = Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();
  }

  
  
  getIdByEmail() async {
    id = await ReadService.getOrgIdByEmail(email);
  }
  dynamic _incrementCounter() {
      if (progressvalue <= 7) {
      progressvalue++;
    }
    if (_counter == 0 && progressvalue == 1) {
      setState(() {
        value = "Audit Planning";
        _counter++;
      });
    }
    if (_counter == 1 && progressvalue == 2) {
      setState(() {
        value = "Understanding Internal Controls";
        _counter++;
      });
    }
    if (_counter == 2 && progressvalue == 3) {
      setState(() {
        value = "Risk Assessment";
        _counter++;
      });
    }
    if (_counter == 3 && progressvalue == 4) {
      setState(() {
        value = " Controls Testing";
        _counter++;
      });
    }
    if (_counter == 4 && progressvalue == 5) {
      setState(() {
        value = "Substantive Procedures";
        _counter++;
      });
    }
    if (_counter == 5 && progressvalue == 6) {
      setState(() {
        value = "Analytical Procedures";
        _counter++;
      });
    }
    if (_counter == 6 && progressvalue == 7) {
      setState(() {
        value = "Finalizing the Audit and Report";
      });
      return showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: const Text('Project Complete!'),
                  content: const Text('Congratulations'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    )
                  ]));
    }
  }

  dynamic _decrementCounter() {
    if (progressvalue != 0) {
      progressvalue--;
    }
    if (_counter == 0) {
      setState(() {
        value = "No progress";
      });
      return showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('You cannot decrement more!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    )
                  ]));
    }

    if (_counter == 0) {
      setState(() {
        value = "Audit Planning";
        _counter--;
      });
    }
    if (_counter == 1) {
      setState(() {
        value = "Understanding Internal Controls";
        _counter--;
      });
    }
    if (_counter == 2) {
      setState(() {
        value = "Risk Assessment";
        _counter--;
      });
    }
    if (_counter == 3) {
      setState(() {
        value = " Controls Testing";
        _counter--;
      });
    }
    if (_counter == 4) {
      setState(() {
        value = "Analytical Procedures";
        _counter--;
      });
    }
    if (_counter == 5) {
      setState(() {
        value = "Substantive Procedures";
        _counter--;
      });
    }
    if (_counter == 6) {
      setState(() {
        value = "Finalizing Audit and Report";
        _counter--;
      });
    }

    
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Project is in Stage ' + '$_counter' + ':',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headline5,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                  child: Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 6,
                        currentStep: _counter,
                        size: 40,
                        selectedColor: MyColors.blueColor,
                        unselectedColor: MyColors.mistColor,
                        customStep: (index, color, _) =>
                            color == MyColors.blueColor
                                ? Container(
                                    color: color,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    color: color,
                                    child: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(primary: MyColors.blueColor,),
                  child: const Text('Next'),
                ),
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrement',
        backgroundColor: MyColors.blueColor,
        child: const Icon(Icons.backspace),
      ),
    );
  }
}



