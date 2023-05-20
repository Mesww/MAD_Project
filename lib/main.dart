import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutu/Pages/registerandlogin/widget_tree.dart';
import 'package:mutu/provider/forms/saleform.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mutu/provider/welcomeprovider.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: ((context) => Profile())),
        Provider(create: ((context) => Saleform())),
        Provider(create: ((context) => Welcomeprovider())),
        Provider(create: ((context) => Productprovider())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WidgetTree(),
          theme: ThemeData(
              primaryColorDark: Color(0xFF7B8FA1),
              cardTheme: CardTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: Color(0xFF344D67),
                  color: Color(0xFFFAD6A5)),
              appBarTheme: AppBarTheme(backgroundColor: Color(0xFF344D67)),
              primaryColor: Color(0xFFFAD6A5),
              scaffoldBackgroundColor: Color(0xFF567189),
              textTheme: TextTheme(
                  titleMedium: GoogleFonts.andika(
                    textStyle: TextStyle(
                      color: Color(0xFFFAD6A5),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  headlineLarge: GoogleFonts.andika(
                    textStyle: TextStyle(
                      color: Color(0xFFFAD6A5),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  headlineMedium: GoogleFonts.andika(
                    textStyle: TextStyle(
                      color: Color(0xFFFAD6A5),
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  headlineSmall: GoogleFonts.andika(
                    textStyle: TextStyle(
                      color: Color(0xFFFAD6A5),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              iconTheme: IconThemeData(color: Color(0xFF344D67)),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Color(0xFF7B8FA1),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCFB997)),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCFB997)),
                    borderRadius: BorderRadius.circular(15)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFFCFB997)),
                ),
              ))),
    ),
  );
}
