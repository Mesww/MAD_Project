import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends ChangeNotifier {
  String password = '';
  String email = '';
  String confirm = '';

  void set_password(String password) => this.password = password;
  void set_email(String email) => this.email = email;
  void set_confirm(String confirm) => this.confirm = confirm;

  String get get_password => password;
  String get get_email => email;
  String get get_confirm => confirm;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((User? user) => user!.uid);

  Future<String> getCurrentID() async {
    return (_firebaseAuth.currentUser!).uid;
  }

  Future getCurrentUser() async {
    return (_firebaseAuth.currentUser);
  }


  

}

