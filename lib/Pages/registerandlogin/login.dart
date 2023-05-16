import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/Pages/registerandlogin/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mutu/provider/profile.dart';
import 'package:mutu/Pages/registerandlogin/forgetpassword.dart';

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
  bool obscure_password = true;
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
                      Icon(
                        Icons.shopping_cart_rounded,
                        color: Color(0xFFFAD6A5),
                        size: 80,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('MUTU',
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text('Welcome Back to MUTU, Easy 2 Sell && Easy 2 Buy ',
                          style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) => user.set_email(email!),
                          validator: MultiValidator([
                            EmailValidator(errorText: 'Email invalid syntax'),
                            RequiredValidator(
                                errorText: 'Please enter email address')
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
                              errorText: 'Please enter password '),
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
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Forgetpassword())));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forget password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
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
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Color(0xFFFAD6A5),
                                      textColor: Color(0xFF344D67));

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Navigatorbar()));
                                });
                              } on FirebaseAuthException catch (e) {
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
                                  child: Text('Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: 15,
                                              color: Color(0xFF344D67),
                                              fontWeight: FontWeight.bold))))),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member? ',
                              style: Theme.of(context).textTheme.headlineSmall),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text('Register now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontWeight: FontWeight.bold))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
