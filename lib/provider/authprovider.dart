import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum stateauth { authing, unAuth, authed }

class authprovider extends ChangeNotifier {
  late FirebaseAuth auth;
  late User users;
  late stateauth status= stateauth.unAuth;
  late String error;

  authprovider() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user == null) {
        print("No have a user");
        status = stateauth.unAuth;
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SecondRoute(),));
      } else {
        users = user;
        print("have user");
      }
      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      status = stateauth.authing;
      notifyListeners();

      return true;
      await Future.delayed(Duration(seconds: 2));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        error = "invalid-email";
      } else if (e.code == 'user-not-found') {
        error = "user-not-found";
      } else if (e.code == 'wrong-password') {
        error = "wrong-password";
      } else {}
      return false;
    }
  }

  logout() async {
    await auth.signOut();
    status = stateauth.unAuth;
    notifyListeners();

  }
}
