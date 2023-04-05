import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

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
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          }));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }));
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please input your email to reset password',
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  EmailValidator(errorText: 'Email invalid syntax'),
                  RequiredValidator(errorText: 'Plase enter email address')
                ]),
                controller: ip,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      passwordReset();
                    }
                  },
                  child: Text('Reset Password')),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text('Change your mind?'))
            ],
          ),
        ),
      ),
    );
  }
}
