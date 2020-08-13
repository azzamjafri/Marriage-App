import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marriage/Database/database.dart';

import 'chat_box.dart';

class AcceptedChats extends StatefulWidget {
  @override
  _AcceptedChatsState createState() => _AcceptedChatsState();
}

class _AcceptedChatsState extends State<AcceptedChats> {

  static String myName = "";

  @override
  void initState() {

   getMyName();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(
        children: [
          // for (int i = 0; i < 25; i++) getChatCard(),
          getChatCard(),
        ],
      ),
    );
  }

  getChatCard() {
    return GestureDetector(
      onTap: () {
        createChatRoomandStartConversation('Name');
      },
      child: Container(
        height: 90.0,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                    elevation: 8.0,
                    shadowColor: Colors.green.shade500,
                    child: Image.asset('images/pic2.jpg')),
              ),
              Padding(padding: EdgeInsets.only(right: 10.0)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Text('Last Message',
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 16.0)),
                  Padding(padding: EdgeInsets.only(top: 3.0)),
                  Text('Today, 11:25 am',
                      style:
                          TextStyle(color: Colors.grey[500], fontSize: 11.0)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  createChatRoomandStartConversation(String userName) {
    List<String> user = [userName, myName];
    String id = getChatRoomId(userName, myName);
    Map<String, dynamic> chatRoomMap = {
      'users' : user,
      'chatroomId' : id,
    };

    Database().createChatRoom(id, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox(id, myName)));
  }
  getMyName() async {
     var user = await FirebaseAuth.instance.currentUser();
    
    Firestore.instance.collection('users').document(user.uid).get().then((value) {
       myName = value.data['email'];
        print(myName + "*************");
      // setState() {
      //   myName = value.data['email'];
      //   print(myName + "*************");
      // }
    });
  }
  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0) ) {
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }
}
