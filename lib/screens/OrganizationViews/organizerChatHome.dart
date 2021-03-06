import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'organizerChat.dart';

class OrganizerChatHome extends StatelessWidget {
  final String otherUserID;
  final String currentUserID;
  final String email;
  const OrganizerChatHome({ Key? key,required this.otherUserID, required this.currentUserID, required this.email }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Chat"),
      backgroundColor: Color.fromARGB(255, 38, 146, 173),),
      body:  OrganizerChat( otherUserID:otherUserID, currentUserID: currentUserID, email: email,),
    );
  }
}