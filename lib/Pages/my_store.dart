import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/cart.dart';
import 'package:mutu/Pages/data_store.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final firebase_sale = FirebaseFirestore.instance.collection('products');

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
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cart()));
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 14,),
                child: Icon(
                  Icons.shopping_basket_rounded,
                  color: Color(0xFFFFAD6A5),
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('userid',
                  isEqualTo: context.watch<Profile>().getCurrentID())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: snapshot.data!.docs.map<Widget>((doc) {
                  final String docid = doc.id;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<Productprovider>().setselctproduct(docid);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataInImage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.topRight, children: [
                              Image.network(
                                doc['url'],
                                fit: BoxFit.cover,
                                width: 175,
                                height: 125,
                              ),
                              IconButton(
                                onPressed: () async {
                                  firebase_sale.doc(doc.id).delete();
                                  await FirebaseStorage.instance
                                      .refFromURL(doc['url'])
                                      .delete();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ]),
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
          }),
    );
  }
}
