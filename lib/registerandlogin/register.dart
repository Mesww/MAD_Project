import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutu/registerandlogin/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
// flutter pub add form_field_validator
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/registerandlogin/verify_email.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  Profile user = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
            body: Center(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) => user.set_email(email!),
                        validator: MultiValidator([
                          EmailValidator(errorText: 'Email invalid syntax'),
                          RequiredValidator(
                              errorText: 'Plase enter email address')
                        ]),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        obscureText: true,
                        onSaved: (String? password) =>
                            user.set_password(password!),
                        validator: RequiredValidator(
                            errorText: 'Plase enter password '),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        onSaved: (String? confirm) =>
                            user.set_confirm(confirm!),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Plase enter confirm password ')
                        ]),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password',
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState?.save();
                            try {
                              //wait for create user id
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: user.get_email,
                                      password: user.get_password);
                              Fluttertoast.showToast(
                                      msg: 'Success',
                                      gravity: ToastGravity.CENTER)
                                  .then((value) {
                                formkey.currentState?.reset();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyEmail()));
                              });
                            } on FirebaseAuthException catch (e) {
                              // print(e.code);
                              // print(e.message);
                              Fluttertoast.showToast(
                                  msg: e.message!,
                                  gravity: ToastGravity.CENTER);
                            }
                          }
                        },
                        child: Text('Ok')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text('Already Have a account?'))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
