import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/Pages/registerandlogin/login.dart';
import 'package:mutu/Pages/registerandlogin/widget_tree.dart';
import 'package:mutu/provider/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Pages/registerandlogin/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController password_con = TextEditingController();
  Profile user = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool obscure_password = true;
  bool obscure_confirm = true;

  //Geolocation
  Position? _position;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    _position = position;
    print(_position);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  initState() {
    _getCurrentLocation();
    super.initState();
    debugPrint('$_position');
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                          color: Theme.of(context).primaryColor, size: 80),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Welcome to MUTU',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 30),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Please enter email and password',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) => user.set_email(email!),
                          validator: MultiValidator([
                            EmailValidator(errorText: 'Email invalid syntax'),
                            RequiredValidator(
                                errorText: 'Plase enter email address')
                          ]),
                          decoration: InputDecoration(labelText: 'Email')
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: password_con,
                          obscureText: obscure_password,
                          onSaved: (String? password) =>
                              user.set_password(password!),
                          validator: RequiredValidator(
                              errorText: 'Plase enter password '),
                          decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(obscure_password
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscure_password = !obscure_password;
                                      });
                                    },
                                  ))
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          obscureText: obscure_confirm,
                          controller: confirmpass,
                          onSaved: (String? confirm) =>
                              user.set_confirm(confirm!),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Plase enter confirm password ';
                            }
                            if (confirmpass.text != password_con.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(obscure_confirm
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscure_confirm = !obscure_confirm;
                                      });
                                    },
                                  ))
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState?.save();
                              try {
                                //wait for create user id
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: user.get_email,
                                        password: user.get_password)
                                    .then((value) {
                                  String lat =
                                      _position!.latitude.toString().trim();
                                  String long =
                                      _position!.longitude.toString().trim();
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(value.user?.uid)
                                      .set({
                                    'name': 'Anonymus',
                                    'age': '',
                                    'about': '',
                                    'email': value.user?.email,
                                    'uid': value.user?.uid,
                                    'lat': lat,
                                    'long': long,
                                    'urlbackground':
                                        'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148907303.jpg?w=740&t=st=1681908736~exp=1681909336~hmac=5fdb1fbeecaf7427a7f2272c512478f9f439189687c9c4bfd9b1a9b2f9f6a2fc',
                                    'urlprofile':
                                        'https://icons.iconarchive.com/icons/iconarchive/cute-animal/256/Cute-Cat-icon.png'
                                  });
                                  verifyemail();
                                  Fluttertoast.showToast(
                                          msg:
                                              'please verify email ${value.user?.email}',
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Color(0xFFFAD6A5),
                                          textColor: Color(0xFF344D67))
                                      .then((value) {
                                    formkey.currentState?.reset();
                                  });
                                });
                              } on FirebaseAuthException catch (e) {
                                // print(e.code);
                                // print(e.message);
                                Fluttertoast.showToast(
                                    msg: e.message!,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Color(0xFFFAD6A5),
                                    textColor: Color(0xFF344D67));
                              }
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFAD6A5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text('Ok',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: 15,
                                              color: Color(0xFF344D67),
                                              fontWeight: FontWeight.bold))))),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Already Have a account?',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  final auth = FirebaseAuth.instance;
  bool isEmailverified = false;
  late User user_;
  late Timer timer;
  bool resent = false;
  Future verifyemail() async {
    final user_ = auth.currentUser!;
    user_.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> checkEmailVerified() async {
    user_ = auth.currentUser!;
    await user_.reload();
    if (user_.emailVerified) {
      timer.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => WidgetTree())));
    }
  }
}
