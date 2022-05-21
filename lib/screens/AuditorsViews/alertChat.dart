import 'dart:async';
import 'dart:io';
import 'package:url_launcher/link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controlller/WriteMessageService.dart';


class AdviseeChat extends StatefulWidget {
  final String otherUserID;
  final String currentUserID;
  final String email;
  const AdviseeChat({Key? key, required this.otherUserID,required this.currentUserID,required this.email}) : super(key: key);

  @override
  State<AdviseeChat> createState() => _AlertChatState();
}

class _AlertChatState extends State<AdviseeChat> {
  List<QueryDocumentSnapshot> listMessage = [];



  bool isLoading = false;

  String imageUrl = "";
  int _limit = 20;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += 20;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listScrollController.addListener(_scrollListener);
  }

  Future<void> retrieveLostData() async {}

  Future getImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();


      if (result != null) {
        print(result.files.single.path);

        setState(() {
          isLoading = true;
        });
        uploadFile(result.files.single.path!);
      }
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future getImageCamera() async {
  //   try {
  //     List<Media>? res = await ImagesPicker.openCamera(
  //       pickType: PickType.image,
  //       quality: 0.8,
  //       maxSize: 800,
  //       maxTime: 800,
  //       // maxSize: 500,
  //     );
  //     if (res != null) {
  //       print(res[0].path);
  //
  //       setState(() {
  //         isLoading = true;
  //       });
  //       uploadFile(res[0].path);
  //     }
  //   } on PlatformException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future uploadFile(String path) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = WriteMessageService.uploadFile(path, fileName);
    try {
      print("han agbea");
      TaskSnapshot snapshot = await uploadTask;
      // print(snapshot.ref.getDownloadURL());
      imageUrl = await (await snapshot).ref.getDownloadURL();
      print("nhi ya");
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 0);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      WriteMessageService.sendMessage(content, type, widget.currentUserID,
          widget.otherUserID, widget.email);
      listScrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      print("Nothing to send");
    }
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      if (document.get("senderID") == widget.currentUserID) {
        // Right (my message)
        return Column(
          children: [
            Row(
              children: <Widget>[
                if (document.get("type") == 1) Container(
                        child: Text(
                          document.get("content"),
                          style: TextStyle(color: Colors.black),
                        ),
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)),
                      ) else Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          child:  Icon(Icons.file_copy),
                          onTap: () async{

                            if (!await launchUrl(
                              Uri.parse(document.get("content")),
                            mode: LaunchMode.externalApplication,
                            )) {
                            throw 'Could not launch '+document.get("content");
                            }
                          },
                        )
                      ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            Container(
              child: Text(
                DateFormat('dd MMM kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(document.get("timestamp")))),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50, top: 0, bottom: 5),
            )
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 25.0,
                    child: Text(
                      "${document.get("name")[0]}",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                  Container(width: 10),
                  document.get("type") == 1
                      ? Container(
                          child: Text(
                            document.get("content"),
                            style: TextStyle(color: Colors.white),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(left: 10),
                        )
                      : Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 10),
                      child: InkWell(
                        child: Icon(Icons.file_copy),
                        onTap: () async{

                          if (!await launchUrl(
                              Uri.parse(document.get("content")),
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch '+document.get("content");
                          }
                        },
                      )
                  ),
                ],
              ),
              Container(
                child: Text("by: " + document.get("name"),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontStyle: FontStyle.italic)),
                margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
              ),
              Container(
                child: Text(
                  DateFormat('dd MMM kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(document.get("timestamp")))),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
                margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildListMessage() {
    return Flexible(
        child: StreamBuilder<QuerySnapshot>(
      stream: WriteMessageService.getChatStream(
          widget.otherUserID, widget.currentUserID, _limit),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          listMessage = snapshot.data!.docs;
          if (listMessage.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) =>
                  buildItem(index, snapshot.data?.docs[index]),
              itemCount: snapshot.data?.docs.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return Center(child: Text("No message here yet..."));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
      },
    ));
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image

          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.file_copy_rounded),
                onPressed: (){

                },
                color: Colors.green,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 1);
                },
                style: TextStyle(color: Colors.green, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 1),
                color: Colors.green,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // List of messages
            buildListMessage(),

            // Input content
            buildInput(),
          ],
        ),

        // Loading
        buildLoading()
      ],
    );
  }
}
