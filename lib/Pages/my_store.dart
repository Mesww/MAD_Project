import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final firebase_sale =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Navigatorbar()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                )),
            const SizedBox(width: 100.0),
            FaIcon(
              FontAwesomeIcons.shoppingBasket,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: snapshot.data!.docs.map<Widget>((doc) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Image.network(
                              doc['url'],
                              fit: BoxFit.cover,
                              width: 175,
                              height: 125,
                            ),
                            Text(
                              '${doc['name']} ${doc['price']} Bath.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            // Center(child:

            // } Column(
            //   children: <Widget>[
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //       primary: Theme.of(context).primaryColor,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 8, vertical: 8)),
            //   child: SizedBox(
            //     width: 200,
            //     height: 150,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Image.network(
            //           'https://media.istockphoto.com/id/1309042044/photo/interior-design-of-stylish-dining-room-interior-with-family-wooden-table-modern-chairs-plate.jpg?b=1&s=170667a&w=0&k=20&c=L1uZ3qcVPS19aTnjjLU-3nFAtbaL6Yq-BLkdcvG9gMs=',
            //           fit: BoxFit.cover,
            //           width: 175,
            //           height: 125,
            //         ),
            //         Text(
            //           'Table 4000 Bath.',
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineSmall!
            //               .copyWith(
            //                   color: Theme.of(context)
            //                       .scaffoldBackgroundColor),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //       primary: Theme.of(context).primaryColor,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 8, vertical: 8)),
            //   child: SizedBox(
            //     width: 200,
            //     height: 150,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Image.network(
            //           'https://images.pexels.com/photos/3992870/pexels-photo-3992870.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            //           fit: BoxFit.cover,
            //           width: 175,
            //           height: 125,
            //         ),
            //         Text(
            //           'Table 40 Bath.',
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineSmall!
            //               .copyWith(
            //                   color: Theme.of(context)
            //                       .scaffoldBackgroundColor),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //       primary: Theme.of(context).primaryColor,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 8, vertical: 8)),
            //   child: SizedBox(
            //     width: 200,
            //     height: 150,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Image.network(
            //           'https://images.pexels.com/photos/1714208/pexels-photo-1714208.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            //           fit: BoxFit.cover,
            //           width: 175,
            //           height: 125,
            //         ),
            //         Text(
            //           'Table 66000 Bath.',
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineSmall!
            //               .copyWith(
            //                   color: Theme.of(context)
            //                       .scaffoldBackgroundColor),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //       primary: Theme.of(context).primaryColor,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 8, vertical: 8)),
            //   child: SizedBox(
            //     width: 200,
            //     height: 150,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Image.network(
            //           'https://images.pexels.com/photos/434346/pexels-photo-434346.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            //           fit: BoxFit.cover,
            //           width: 175,
            //           height: 125,
            //         ),
            //         Text(
            //           'Table 45000 Bath.',
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineSmall!
            //               .copyWith(
            //                   color: Theme.of(context)
            //                       .scaffoldBackgroundColor),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ],
            // ),
            // ),
          }),
    );
  }
}
