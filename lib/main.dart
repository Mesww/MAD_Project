import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutu/registerandlogin/register.dart';
import 'package:mutu/Page/Welcome.dart';
import 'package:mutu/registerandlogin/verify_email.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
