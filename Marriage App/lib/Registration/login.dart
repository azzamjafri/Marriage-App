import 'package:flutter/material.dart';
import 'package:marriage/Navigation/navBar.dart';
import './signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './forgotpassword.dart';
import 'user_info.dart';

bool valid;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthResult authresult;
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  final auth = FirebaseAuth.instance;

  void submit(String email, String password, BuildContext ctx) async {
    try {
      setState(() {
        loading = true;
      });

      authresult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(() {
      loading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NavBar()));
    } on PlatformException catch (error) {
      var message = ' An error occured, please check credentials';
      if (error.message != null) {
        message = error.message;
      }

      /*  Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
      ));
*/

      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        buttons: [
          DialogButton(
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            color: Colors.white,
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ).show();
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        loading = false;
      });
    }
  }

void reset() async{
  auth.sendPasswordResetEmail(email: email);
}


  void trysubmit(BuildContext context) async {
    valid = formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (valid) {
      formkey.currentState.save();
      submit(email.trim(), password.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
          },
                  child: Text("Sign in to",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Stack(children: [
            Container(
              height: 750,
            ),
            Positioned(
                left: 140,
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('images/logo.jpg'),
                )),
            Positioned(
              top: 120,
              left: 106,
              child: Text(
                'Jhatpat shadi kro',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 200,
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
                      child: new TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' Enter A Vaid Email';
                          } else
                            return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            decoration: TextDecoration.none),
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
                  ),
                ),
              ),
            ),
            Positioned(
              top: 300,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: new TextFormField(
                            key: ValueKey('password'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return ' Enter A Vaid Password';
                              } else
                                return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                            cursorColor: Colors.green,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Your Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 20,
                                )),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            "Forgot",
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                          onPressed: () {
                            reset();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
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
              top: 290,
              left: 20,
              child: Text(
                'Shssss, my password is',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 390,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RaisedButton(
                    onPressed: () {
                      submit(email, password, context);
                    },
                    child: Container(
                      height: 60,
                      width: 330,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          if(!loading)
                          Text("Sign in",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white))
                          else
                          CircularProgressIndicator(backgroundColor: Colors.white,),
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
              top: 480,
              left: 115,
              child: Text(
                'oh ! Not Registered yet?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 500,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    child: Container(
                      height: 45,
                      width: 330,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          Text("Register Now",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green)),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.green,
                        )),
                    color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
