import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/data_store.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not laucnch $googleURL';
  }


  Future<void> deleteSubcollection(String? parentDocumentId) async {
    CollectionReference subCollectionRef =
        firebase_sale.doc(parentDocumentId!).collection('data');

    QuerySnapshot querySnapshot = await subCollectionRef.get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: data['email'],
      query:
          'subject= Offers for ${data['name']} Price ${data['price']} THB &body=  ',
    );
    String url = params.toString();
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  late Map data;

  final firebase_sale = FirebaseFirestore.instance.collection('cart');
  final firebase_product = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7B8FA1),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigatorbar(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 60.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Color(0xFFFFAD6A5),
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              'Cart',
              style: TextStyle(color: Color(0xFFFFAD6A5)),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .where('uid', isEqualTo: context.read<Profile>().getCurrentID())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return SizedBox(); // Return an empty widget or a default view if there's no data
          }

          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var Cartdata = snapshot.data!.docs[index];
                var idproduct = snapshot.data!.docs[index].id;

                return StreamBuilder<QuerySnapshot>(
                  stream: Cartdata.reference.collection('data').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return SizedBox(); // Return an empty widget or a default view if there's no data
                    }

                    final datadoc = snapshot.data!.docs;

                    return SizedBox(
                      height: 90,
                      width: 200,
                      child: ListView.builder(
                        itemCount: datadoc.length,
                        itemBuilder: (context, index) {
                          final String docid = datadoc[index].id;
                          final data = datadoc[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<Productprovider>()
                                  .setselctproduct(docid);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DataInImage(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      width: 50,
                                      child: Image.network(
                                        data['url']!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    'Name: ${data['name']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                        ),
                                  ),
                                  subtitle: Text(
                                    'category: ${data['category']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                        ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await firebase_sale
                                          .doc(idproduct)
                                          .delete()
                                          .then((value) {
                                        deleteSubcollection(idproduct)
                                            .then((value) {
                                          firebase_product
                                              .doc(idproduct)
                                              .update({'stage': true});
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 237, 96, 85),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
