import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/Pages/registerandlogin/Auth.dart';
import 'package:mutu/Pages/registerandlogin/login.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Navigatorbar();
          } else {
            return Login();
          }
        }));
  }
}
