import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Pages/address.dart';
import 'package:mutu/Pages/cart.dart';
import 'package:mutu/Pages/my_store.dart';
import 'package:mutu/Pages/favorite.dart';
import 'package:mutu/Pages/setting.dart';
import 'package:mutu/Pages/registerandlogin/login.dart';
import 'package:mutu/Pages/personnalinfo.dart';
import 'package:mutu/Pages/payment/add_wallet.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({Key? key}) : super(key: key);

  @override
  _UserprofileState createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(context.read<Profile>().getCurrentID())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final data = snapshot.data!.data() as Map;
                    return Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(
                            color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.only(bottom: 40),
                            height: 150,
                            width: double.infinity,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                data['urlbackground'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(data['urlprofile']),
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ]);
                  }
                  return CircularProgressIndicator();
                }),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Column(
                children: [
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Personnalinfo())));
                      // Fluttertoast.showToast(msg: 'Personal infomation');
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.badge,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Personal information',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.luggage,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My purchase',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyStore()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My store',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: ((context) => Address())));
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.car_rental,
                  //         size: 30,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         'Edit address',
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headlineSmall!
                  //             .copyWith(fontSize: 15),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AddWallet()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Payment',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Favorite())));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.heart_broken_outlined,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Desired products',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: ((context) => Setting())));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Setting',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
