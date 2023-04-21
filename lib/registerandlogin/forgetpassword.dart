import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final ip = TextEditingController();
  @override
  void dispose() {
    ip.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: ip.text.trim());

      Fluttertoast.showToast(
              msg: 'Password reset link sent! Check your email',
              gravity: ToastGravity.CENTER,
              backgroundColor: Color(0xFFFAD6A5),
              textColor: Color(0xFF344D67))
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
      // showDialog(
      //     context: context,
      //     builder: ((context) {
      //       return AlertDialog(
      //         content: Text('Password reset link sent! Check your email'),
      //       );
      //     }));
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: e.message!,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xFFFAD6A5),
          textColor: Color(0xFF344D67));
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please input your email to reset password',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: MultiValidator([
                    EmailValidator(errorText: 'Email invalid syntax'),
                    RequiredValidator(errorText: 'Plase enter email address')
                  ]),
                  controller: ip,
                  decoration: InputDecoration(labelText: 'Email').applyDefaults(
                      Theme.of(context).inputDecorationTheme.copyWith(
                          labelStyle:
                              Theme.of(context).textTheme.headlineSmall)),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        passwordReset();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFFFAD6A5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Reset Password',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: 15,
                                  color: Color(0xFF344D67),
                                  fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Change your mind?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
