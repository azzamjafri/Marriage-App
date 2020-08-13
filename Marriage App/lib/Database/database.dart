import 'package:cloud_firestore/cloud_firestore.dart';

class Database {



  getUserbyUserName(String username) async {
    return await Firestore.instance.collection('users').where('firstName', isEqualTo: username).getDocuments();
  }

  getUserByEmail(String email) async {

    return await Firestore.instance.collection('users').where('email', isEqualTo: email).getDocuments();
  }
  createChatRoom(String chatRoomId, chatRoomMap) {

    Firestore.instance.collection('messages')
          .document(chatRoomId).setData(chatRoomMap).catchError( (error){
            print(error.toString());
          });
  }


  addConversationMessages(String chatRoomId, messageMap) {

    Firestore.instance.collection('messages').document(chatRoomId).collection('chats').add(messageMap).catchError((error){
      print(error.toString() + " ***************");
    });
  }

  getConversationMessages(String chatRoomId) async {

    return await Firestore.instance.collection('messages')
            .document(chatRoomId)
            .collection('chats')
            .orderBy('time')
            .snapshots();
  }
}