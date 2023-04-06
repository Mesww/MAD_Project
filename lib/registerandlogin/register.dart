import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
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
  TextEditingController confirmpass = TextEditingController();
  Profile user = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool obscure_password = true;
  bool obscure_confirm = true;
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
                          onSaved: (String? confirm) =>
                              user.set_confirm(confirm!),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Plase enter confirm password ';
                            }
                            if (user.get_confirm != user.get_password) {
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
                                        password: user.get_password);
                                Fluttertoast.showToast(
                                        msg: 'Success',
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color(0xFFFAD6A5),
                                        textColor: Color(0xFF344D67))
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
}
