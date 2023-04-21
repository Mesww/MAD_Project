import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Pages/address.dart';
import 'package:mutu/Pages/my_store.dart';
import 'package:mutu/Pages/payment/favorite.dart';
import 'package:mutu/Pages/setting.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:mutu/Pages/personnalinfo.dart';
import 'package:mutu/Pages/payment/add_wallet.dart';

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
            Stack(alignment: Alignment.bottomCenter, children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.only(bottom: 40),
                height: 150,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148907303.jpg?w=740&t=st=1681908736~exp=1681909336~hmac=5fdb1fbeecaf7427a7f2272c512478f9f439189687c9c4bfd9b1a9b2f9f6a2fc',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://icons.iconarchive.com/icons/iconarchive/cute-animal/256/Cute-Cat-icon.png'),
                radius: 40,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ]),
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
                    onTap: () {},
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
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: ((context) => Address())));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.car_rental,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Edit address',
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
