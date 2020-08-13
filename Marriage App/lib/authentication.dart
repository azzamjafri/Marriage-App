import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Navigation/navBar.dart';
import 'Registration/login.dart';

class Authentication{
  getUser() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext bc, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return NavBar();
        }
        else {
          return LoginPage();
        }
      },
    );
  }
}