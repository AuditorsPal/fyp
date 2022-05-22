
import 'package:auditorpal/screens/AuditorsViews/Allprojs.dart';
import 'package:flutter/material.dart';
import 'package:auditorpal/screens/AuditorsViews/AllProjects.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 38, 146, 173),
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear), onPressed: _controller.clear),
                    hintText: 'Search',
                    border: InputBorder.none),
              ),

        
            ),
          )),
          body: AllProjects(),
    );
  }
}
