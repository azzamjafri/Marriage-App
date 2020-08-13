import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriage/HomeScreen/HomeScreen.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Bookmarks",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: getListView(),);
  }
  getListView() {
    return StreamBuilder(
      stream: Firestore.instance.collection("UserBookmarks").where("bookmarkedBy",isEqualTo:uid).snapshots(),
      builder: ( bc, snapshot){
        if(!snapshot.hasData){
          return Center(child: Text("Loading.."),);
        }
        else{
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext bc, int index){
              var item=snapshot.data.documents[index];
              return getCard(item);
            },

          );
        }
      },
    );
  }

  getCard(DocumentSnapshot data) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${data['firstName']} ${data['surname']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Spacer(),
              Text(data['dob']+" | "+ data['height']),
              IconButton(
                icon: Icon(Icons.remove_circle_outline,color: Colors.red,),
                onPressed:()=> deleteBookmark(data),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['caste']),
                      Text(data['placeOfBirth']),
                      Text(data['educationStatus']),
                      Text(data['jobStatus'])
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data['picURLS'].length,
                      itemBuilder: (bc,index){
                        var url=data["picURLS"][index];
                        return Image.network(url,height: 100,width: 100,);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 2,color: Colors.green)
                    ),
                    child: Center(child: Text("More Info",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),)),
                  ),
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green
                    ),
                    height: 30,
                    child: Center(child: Text("Connect Request",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),))),
              ))
            ],
          )
        ],
      ),
    );
  }

  deleteBookmark(DocumentSnapshot data) async{
    var info=data.documentID;

    showDialog(context: context,
        builder: (_){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Deleted!"),
              ],
            ),
          );
        }
    );
    await Firestore.instance.collection("UserBookmarks").document(info).delete();

  }

}
