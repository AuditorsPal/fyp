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
      appBar:AppBar(title: Text("Chating... "),),
      body:  OrganizerChat( otherUserID:otherUserID, currentUserID: currentUserID, email: email,),
    );
  }
}