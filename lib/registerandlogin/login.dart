import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Page/Welcome.dart';
import 'package:mutu/registerandlogin/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mutu/registerandlogin/profile.dart';
import 'package:mutu/registerandlogin/forgetpassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController input_username = TextEditingController();
  TextEditingController input_password = TextEditingController();
  Profile user = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formkey = GlobalKey<FormState>();
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
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Forgetpassword())));
                        }, child: Text('Forget password?')),
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: user.get_email,
                                      password: user.get_password)
                                  .then((value) {
                                Fluttertoast.showToast(
                                    msg: 'Success',
                                    gravity: ToastGravity.CENTER);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Welcome()));
                              });
                            } on FirebaseAuthException catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.message!,
                                  gravity: ToastGravity.CENTER);
                            }
                          }
                        },
                        child: Text('Login')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Text('register'))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
