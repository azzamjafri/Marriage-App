

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marriage/HomeScreen/profileinfo.dart';
// import 'file:///D:/flutterProjects/Marriage-app/lib/Profile/myprofile.dart';

import 'HomeScreen.dart';

class UnmarriedPage extends StatefulWidget {
  UnmarriedPage({this.gender});
  final String gender;
  @override
  _UnmarriedPageState createState() => _UnmarriedPageState();
}

class _UnmarriedPageState extends State<UnmarriedPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: getListView(),);
  }

  getListView() {
    return StreamBuilder(
      stream: Firestore.instance.collection("users").where("gender", isEqualTo: widget.gender).where("personType", isEqualTo: "unmarried").snapshots(),
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
                // child: Text("${data['firstName']} ${data['surname']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                child: Text("${data['firstName']} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Spacer(),
              Text(data['dob']+" | "+ data['height']),
              IconButton(
                icon: Icon(Icons.bookmark_border,color: Colors.green,),
                onPressed:()=> addBookmark(data),
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
                  child: InkWell(

                    onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfileInfo(data: data,))),
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


   addBookmark(DocumentSnapshot data) async{
    showDialog(context: context,
    builder: (_){
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Bookmarked!"),
          ],
        ),
      );
    }
    );
    var info=data.data;
    info['bookmarkedBy']=uid;
    await Firestore.instance.collection("UserBookmarks").add(info);
  }
}

