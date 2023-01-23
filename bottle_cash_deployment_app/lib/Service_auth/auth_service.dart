import 'package:bottle_cash_deployment_app/Screen/Home.dart';
import 'package:bottle_cash_deployment_app/Screen/LoginPage.dart';
import 'package:bottle_cash_deployment_app/Navbar/Persistent_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth authService = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final User? user = authService.currentUser;

class AuthService {
  final auth = FirebaseAuth.instance;
  //hanldestate
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Persistent_navbar();
          } else {
            return LoginPage();
          }
        });
  }

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await authService.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await authService.signOut();
  }
}
