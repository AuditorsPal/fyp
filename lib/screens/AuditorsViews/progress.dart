import 'package:flutter/material.dart';

class progress extends StatefulWidget {
  const progress({Key? key}) : super(key: key);

  @override
  State<progress> createState() => _progressState();
}

class _progressState extends State<progress> {
  int _counter = 0;

  dynamic _incrementCounter() {
    if (_counter == 3) {
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
    } else {
      setState(() {
        _counter++;
      });
    }
  }

  dynamic _decrementCounter() {
    if (_counter == 0) {
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
    } else {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: Center(child: Text("Project Progress")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Project is in Stage:',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline1,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                        minHeight: 7,
                      ),
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
                  style: ElevatedButton.styleFrom(primary: Colors.teal[600]),
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
        backgroundColor: Colors.teal[600],
        child: const Icon(Icons.backspace),
      ),
    );
  }
}
