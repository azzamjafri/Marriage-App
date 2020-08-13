import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriage/HomeScreen/divorceePage.dart';
import 'package:marriage/HomeScreen/unmarriedPage.dart';
import 'package:marriage/Registration/login.dart';
String uid;
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  String gender;

  @override
  void initState() {

    getGender();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screens = {
      0: UnmarriedPage(gender: gender),
      1: DivorceePage(gender: gender),
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Jhatpat Shadi Karo",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          FlatButton(
            child: Text(
              "Set Preferences",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: getTabBar(),
          ),
          Expanded(
            flex: 9,
            child: screens[tabIndex],
          )
        ],
      ),
    );
  }

//  getBody() {
//    return SizedBox(
//      height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
//        child: getListView(),);
//  }

//  getListView() {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: ListView(
//        children: [
//          getCard(),
//          getCard(),
//          getCard(),
//          getCard(),
//          getCard()
//        ],
//      ),
//    );
//  }

  getTabBar() {
    return CupertinoSlidingSegmentedControl(
        groupValue: tabIndex,
        onValueChanged: (val) {
          setState(() {
            tabIndex = val;
          });
        },
        children: {
          0: Text("Unmarried"),
          1: Text("Divorcee"),
        });
  }

  getGender() async {
    var user = await FirebaseAuth.instance.currentUser();
    var data =
        await Firestore.instance.collection("users").document(user.uid).get();
    print(data.data['gender']);
    setState(() {
      uid=user.uid;
      print(uid);
      if (data.data['gender'] == "Male") {
        gender = "Female";
        print(gender);
      } else {
        gender = "Male";
      }
    });
    return gender;
  }
}
