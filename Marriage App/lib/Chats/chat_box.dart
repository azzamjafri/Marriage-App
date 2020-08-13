import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:marriage/Database/database.dart';

class ChatBox extends StatefulWidget {
  String chatRoomId;
  String myName;
 
  ChatBox(this.chatRoomId, this.myName);
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;
  bool showEmoji = false;
  @override
  void initState() {
    Database().getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
        showEmoji = false;
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('images/pic2.jpg'),
          ),
          Padding(padding: EdgeInsets.only(right: 10.0)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: 6.0)),
              Text('Online',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12.0)),
            ],
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.details), onPressed: () {}),
        ],
      ),
    );
  }

  getBody() {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.35,
          child: chatMessageList(),
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: getBottom(),
        ),

        (showEmoji
            ? buildSticker()
            : SizedBox(
                height: 0.0,
              )),
      ],
    );
  }

  getBottom() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.face), onPressed: () {
                    setState(() {
                      // showEmoji = !showEmoji;
                    });
                  }),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write your message",
                          border: InputBorder.none),
                      controller: messageController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                    child: Message(
                      text: snapshot.data.documents[index].data['message'],
                      me: snapshot.data.documents[index].data['message'] ==
                          widget.myName,
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': widget.myName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      Database().addConversationMessages(widget.chatRoomId, messageMap);
      messageController.clear();
    }
  }

  buildSticker() {
    return EmojiPicker(
      
      rows: 3,
      columns: 7,
      buttonMode: ButtonMode.MATERIAL,
      // recommendKeywords: ["racing", "horse"],
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
    );
  }
}

class Message extends StatelessWidget {
  // final String from;
  final String text;
  final bool me;

  const Message({Key key, this.text, this.me});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
              color: me ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
                child: Text(text),
              ))
        ],
      ),
    );
  }
}
