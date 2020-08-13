import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Contactus extends StatefulWidget {
  @override
  _ContactusState createState() => _ContactusState();
}

var subject = "Query";
var body = "";
var name = "";
var mail = "";
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ContactusState extends State<Contactus> {
  Future<void> send() async {
    final Email email = Email(
      body: "Name: " + name + "\n" + "Email: " + mail + "\n\n" + body,
      subject: subject,
      recipients: ['cogentwebservices@gmail.com'],
      attachmentPaths: null,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.green,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height / 90,
              left: MediaQuery.of(context).size.width / 40,
              child: Text(
                "We're Happy to",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 25,
              left: MediaQuery.of(context).size.width / 40,
              child: Text(
                "hear from you !!",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 12,
              left: MediaQuery.of(context).size.width / 40,
              child: Text(
                "Let us know your feedback & queries",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.height / 60),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 20,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RaisedButton(
                    onPressed: () {
                      UrlLauncher.launch('tel:+917080855524');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text("Call us",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green)),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RaisedButton(
                    onPressed: () {
                      send();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            'Mail us',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.green,
                        )),
                    color: Colors.green),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 6,
              child: Container(
                height: MediaQuery.of(context).size.height / 13,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Submit Now",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.green,
                        )),
                    color: Colors.green),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 4,
                left: MediaQuery.of(context).size.width / 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      "Send Your message",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {},
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                              cursorColor: Colors.green,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Your Email Address',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.0,
              left: 20,
              child: Text(
                'My Email Address is',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.25,
              left: 20,
              child: Text(
                'My Concern is',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.2,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {},
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                              cursorColor: Colors.green,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Your feedback',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
