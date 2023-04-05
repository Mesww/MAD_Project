import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutu/registerandlogin/register.dart';
import 'package:mutu/Page/Welcome.dart';
import 'package:mutu/registerandlogin/verify_email.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF567189),
          textTheme: TextTheme(
              headlineLarge: GoogleFonts.andika(
                textStyle: TextStyle(
                  color: Color(0xFFFAD6A5),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              headlineSmall: GoogleFonts.andika(
                textStyle: TextStyle(
                  color: Color(0xFFFAD6A5),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              )),
        )),
  );
}
