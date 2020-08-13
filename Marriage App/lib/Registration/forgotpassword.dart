import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String email = "";
  bool loading = false;
  final auth = FirebaseAuth.instance;
  AuthResult authresult;
  final formkey = GlobalKey<FormState>();

  void submit(String email, BuildContext ctx) async {
    auth.sendPasswordResetEmail(email: email).catchError((onError) => Alert(
          context: ctx,
          type: AlertType.error,
          title: "Error",
          buttons: [
            DialogButton(
              child: Text(
                onError.message,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              color: Colors.white,
              onPressed: () async {
                Navigator.pop(context);
              },
            )
          ],
        ).show());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Text("Forgot Password",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.normal)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Stack(
            children: [
              Container(height: 600),
              Positioned(
                top: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text('Let us know your registered email address',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      textAlign: TextAlign.center),
                ),
              ),
              Positioned(
                top: 47,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text("and we'll send you password reset",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      textAlign: TextAlign.center),
                ),
              ),
              Positioned(
                top: 64,
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'instruction',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: 220,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: RaisedButton(
                        onPressed: () {
                          print(email);
                          submit(email, context);
                        },
                        child: Text(
                          "Submit",
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
              ),
              Positioned(
                top: 130,
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
                            Padding(
                              padding: const EdgeInsets.only(right:15.0),
                              child: Icon(
                                Icons.mail,
                                color: Colors.green,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
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
            ],
          ),
        ),
      ),
    );
  }
}
