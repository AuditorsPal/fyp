import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alertChat.dart';

class AdviseeChatHome extends StatelessWidget {
  final String otherUserID;
  final String currentUserID;
  final String email;
  const AdviseeChatHome({ Key? key,required this.otherUserID, required this.currentUserID, required this.email }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Chatting... "),),
      body:  AdviseeChat( otherUserID:otherUserID, currentUserID: currentUserID, email: email,),
    );
  }
}