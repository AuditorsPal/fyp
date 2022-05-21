
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../controlller/readService.dart';
import '../../model/userModel.dart';
import 'auditorChatHome.dart';

class AllChats extends StatefulWidget {
  const AllChats({ Key? key }) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {

  String email = "";
  String id="";
  bool isData=false;
  late final Stream<QuerySnapshot>? chats;

  @override
  void initState() {
    // TODO: implement initState
    email = Provider.of<UserModel>(context, listen: false).email;
    getIdByEmail();
  }

  readProfile() async{
    chats=readChats(id);
    setState(() {
      isData=true;
    });
  }


  getIdByEmail() async{
    id=await ReadService.getIdByEventNameAndEmail(email);
    readProfile();
  }

  static Stream<QuerySnapshot>? readChats(String id) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      final result = db
          .collection("Organization")
          .snapshots();

      return result;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isData ==false? Center(child: CircularProgressIndicator()):  Scaffold(

        body: StreamBuilder<QuerySnapshot>(
            stream: chats,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  "Something went wrong",
                  style: const TextStyle(fontSize: 20),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey,
                              enabled: true,
                              child: ListView.builder(
                                itemBuilder: (_, __) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 48.0,
                                        height: 48.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            Container(
                                              width: 40.0,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                itemCount: 6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: data.size,
                  // Text(data.docs[index]['name'])
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 25.0,
                              child: Text(data.docs[index]["name"][0],
                                  style: TextStyle(fontSize: 30.0)),
                            ),
                            title: Text(
                              data.docs[index]['name'],
                              style: TextStyle(fontSize: 30),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  data.docs[index]['email'],
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  data.docs[index]['businessdetail'],
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdviseeChatHome(
                                      otherUserID: data.docs[index].id, currentUserID: id, email: email,
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}