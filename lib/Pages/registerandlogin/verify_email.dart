// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mutu/Pages/navigatorbar.dart';
// import 'package:mutu/Pages/welcome.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class VerifyEmail extends StatefulWidget {
//   const VerifyEmail({Key? key}) : super(key: key);

//   @override
//   _VerifyEmailState createState() => _VerifyEmailState();
// }

// class _VerifyEmailState extends State<VerifyEmail> {
//   final auth = FirebaseAuth.instance;
//   bool isEmailverified = false;
//   late User user;
//   late Timer timer;
//   bool resent = false;
//   @override
//   void initState() {
//     final user = auth.currentUser!;
//     user.sendEmailVerification();
//     timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       checkEmailVerified();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return showDialog(context: context, builder: builder);
//   }

//   Future<void> checkEmailVerified() async {
//     user = auth.currentUser!;
//     await user.reload();
//     if (user.emailVerified) {
//       timer.cancel();
//       Navigator.pushReplacement(context as BuildContext,
//           MaterialPageRoute(builder: (context) => const Navigatorbar()));
//     }
//   }
// }
