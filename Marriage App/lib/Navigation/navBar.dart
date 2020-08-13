import 'package:flutter/material.dart';
import 'package:marriage/Bookmarks/BookmarkPage.dart';
import 'package:marriage/Chats/chats.dart';
import 'package:marriage/Dummy.dart';
import 'package:marriage/HomeScreen/HomeScreen.dart';
import 'package:marriage/Profile/account.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex=0;
  List<Widget> screens=[
    HomeScreen(),
    BookmarkPage(),
    Chats(),
    Account()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        onTap: (val){
          setState(() {
            currentIndex=val;
          });
          print(val);
          print(currentIndex);
        },
        items: [
          BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(Icons.people,color: Colors.grey,),
            activeIcon: Icon(Icons.people,color: Colors.green,),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(Icons.bookmark,color: Colors.grey,),
            activeIcon: Icon(Icons.bookmark,color: Colors.green,),

          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(Icons.chat,color: Colors.grey,),
            activeIcon:Icon(Icons.chat,color: Colors.green,),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            activeIcon: Icon(Icons.person,color: Colors.green,),
            icon: Icon(Icons.person,color: Colors.grey,),
          ),
        ],
      ),
    );
  }
}
