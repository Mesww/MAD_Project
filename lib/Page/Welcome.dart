import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mutu/registerandlogin/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome'),
          ElevatedButton(
              onPressed: () {
                auth.signOut().then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              child: Text('Logout'))
        ],
      )),
    );
  }
}
