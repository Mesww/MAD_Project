import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutu/Page/Welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  bool isEmailverified = false;
  late User user;
  late Timer timer;
  bool resent = false;
  @override
  void initState() {
    final user = auth.currentUser!;
     user.sendEmailVerification();

      timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An email has been sent to your email please verfity',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          
        ],
      )),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushReplacement(context as BuildContext,
          MaterialPageRoute(builder: (context) => const Welcome()));
    }
  }
}
