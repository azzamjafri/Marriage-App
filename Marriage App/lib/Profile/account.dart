import 'package:flutter/material.dart';
// import 'file:///D:/flutterProjects/Marriage-app/lib/Profile/myprofile.dart';
import 'package:marriage/Registration/login.dart';
import 'contactus.dart';
import 'myprofile.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text("Account",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 40)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: MediaQuery.of(context).size.height / 50),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Positioned(
                top: MediaQuery.of(context).size.height / 50,
                left: MediaQuery.of(context).size.width / 20,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  child: Image.asset('images/profilepic.jpeg'),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3,
                top: MediaQuery.of(context).size.height / 25,
                child: Text("Hey,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height / 40)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 16,
                left: MediaQuery.of(context).size.width / 3,
                child: Text("George Smith",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height / 40)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 13,
                left: MediaQuery.of(context).size.width / 3.3,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                  },
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: MediaQuery.of(context).size.height / 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 70,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.6,
            color: Colors.white,
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 80,
                        child: Text(
                          "You're Subscribed",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height / 40),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.width / 1.2,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white)),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 25,
                        child: Text(
                          "Premium Plan",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Contactus()));
                },
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 80,
                        child: Text(
                          "Contact us",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height / 40),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.width / 1.2,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.black)),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 25,
                        child: Text(
                          "Let us know your feedback & queries",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 80,
                        child: Text(
                          "About us",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height / 40),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.width / 1.2,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.black)),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 25,
                        child: Text(
                          "know who we are & how we started.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 80,
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height / 40),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.width / 1.2,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.black)),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 25,
                        child: Text(
                          "Read company's terms & conditions.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 80,
                        child: Text(
                          "Rate us",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height / 40),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.width / 1.2,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.black)),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        top: MediaQuery.of(context).size.height / 25,
                        child: Text(
                          "Show your love by rate us on playstore",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
