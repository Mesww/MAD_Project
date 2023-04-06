import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mutu/registerandlogin/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UserProfile',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                auth.signOut().then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  'Login Out',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Color(0xFF344D67), fontSize: 15),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
