import 'package:admin_bottle_cash_app/Screen/home.dart';
import 'package:admin_bottle_cash_app/Screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return home();
          } else {
            return login_page();
          }
        });
  }
}
