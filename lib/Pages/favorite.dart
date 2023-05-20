import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/data_store.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  String iddoc = '';

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
                            builder: (context) => Navigatorbar()));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(width: 60.0),
              Icon(
                Icons.favorite,
                color: Color(0xFFFFAD6A5),
              ),
              const SizedBox(width: 16.0),
              Text(
                'Favorite',
                style: TextStyle(color: Color(0xFFFFAD6A5)),
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('fav')
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
                  var favdata = snapshot.data!.docs[index];
                  var docid = snapshot.data!.docs[index].id;

                  return StreamBuilder<QuerySnapshot>(
                    stream: favdata.reference.collection('data').snapshots(),
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
                            final data = datadoc[index];
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<Productprovider>()
                                    .setselctproduct(docid);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DataInImage()),
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
                                                  .backgroundColor),
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
                                                  .backgroundColor),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward,
                                      color: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
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
        ));
  }
}
