import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutu/registerandlogin/profile.dart';
import 'package:mutu/registerandlogin/register.dart';
import 'package:mutu/Pages/welcome.dart';
import 'package:mutu/registerandlogin/verify_email.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Provider(
      auth: Profile(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/login': (context) => Login(),
            '/welcome': (context) => Navigator()
          },
          theme: ThemeData(
              cardTheme: CardTheme(color: Color(0xFF344D67)),
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

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Profile auth = Provider.of(context).auth!;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return signedIn ? Login() : Navigatorbar();
          }
          return CircularProgressIndicator();
        });
  }
}

class Provider extends InheritedWidget {
  late final Profile? auth;
  Provider({Key? key, Widget? child, this.auth})
      : super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);
}
