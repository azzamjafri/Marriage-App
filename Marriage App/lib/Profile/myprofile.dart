import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState() {
    tabController=TabController(length: 3,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              color: Colors.green,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text("My Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.normal)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 20,
                child: Container(
                  height: MediaQuery.of(context).size.height / 7,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.asset('images/profilepic.jpeg'),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 6,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.green,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.asset('images/profilepic.jpeg'),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 6,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.green,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.asset('images/profilepic.jpeg'),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 6,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.green,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.asset('images/profilepic.jpeg'),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 6,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.green,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.asset('images/profilepic.jpeg'),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 6,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.green,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 50,
                  color: Colors.grey[200],
                  child: TabBar(
                    labelColor: Colors.green,
                    indicatorColor: Colors.green,
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          "Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 50,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Personal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 50,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Professional",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 75,
                child: Container(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_transit),
                      Icon(Icons.directions_bike),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
