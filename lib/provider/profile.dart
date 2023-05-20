import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends ChangeNotifier {
  String password = '';
  String email = '';
  String confirm = '';
  String name = '';
  String age = '';
  String about = '';

  void set_password(String password) => this.password = password;
  void set_name(String name) => this.name = name;
  void set_about(String about) => this.about = about;
  void set_age(String age) => this.age = age;
  void set_email(String email) => this.email = email;
  void set_confirm(String confirm) => this.confirm = confirm;

  String get get_password => password;
  String get get_email => email;
  String get get_confirm => confirm;
  String get get_name => name;
  String get get_about => about;
  String get get_age => age;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((User? user) => user!.uid);

  String getCurrentID() {
    return (_firebaseAuth.currentUser!).uid;
  }

  Future getCurrentUser() async {
    return (_firebaseAuth.currentUser);
  }
}
