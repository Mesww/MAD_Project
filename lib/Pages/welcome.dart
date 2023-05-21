import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mutu/Pages/circle.dart';
import 'package:mutu/Pages/data_store.dart';
import 'package:mutu/Pages/search.dart';
import 'package:mutu/provider/forms/saleform.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:mutu/provider/welcomeprovider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String selectcat = 'All';
  @override
  Widget build(BuildContext context) {
    List<String> category = ['All'] + context.read<Saleform>().getitems_cat;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            child: TextField(
                style: TextStyle(color: Color(0xFF567189)),
                readOnly: true,
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
                decoration: InputDecoration(
                        labelText: "Search",
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Theme.of(context).primaryColor)
                    .applyDefaults(Theme.of(context)
                        .inputDecorationTheme
                        .copyWith(
                            labelStyle:
                                Theme.of(context).textTheme.headlineSmall))),
          ),
        ),
        backgroundColor: Color(0xFF567189),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CarouselSlider.builder(
                    itemCount: context
                        .read<Welcomeprovider>()
                        .images_bestseller
                        .length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = context
                          .read<Welcomeprovider>()
                          .images_bestseller[index];
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          context.read<Welcomeprovider>().setactiveIndex(index),
                    )),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'NEAR YOUR AREA',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: category.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectcat = '${category[index]}';
                                      // debugPrint(selectcat);
                                    });
                                  },
                                  child: Card(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    child: Center(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        child: Text(
                                          category[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                      SizedBox(
                        height: 12,
                      ),
                      selectcat == 'All'
                          ? StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('products')
                                  .where('stage', isEqualTo: true)
                                  // .where('userid',
                                  //     isNotEqualTo: context
                                  //         .read<Profile>()
                                  //         .getCurrentID())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  return GridView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      var docid = snapshot.data!.docs[index].id;
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<Productprovider>()
                                              .setselctproduct(docid);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DataInImage()),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Image.network(
                                                        data['url'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF344D67),
                                                            ),
                                                      ),
                                                      Text(
                                                        '${data['price']} Bath',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF344D67),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          //.where('category', isEqualTo: selectcat)
                          : StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('products')
                                  .where('stage', isEqualTo: true)
                                  .where('category', isEqualTo: selectcat)
                                  // .where('userid',
                                  //     isNotEqualTo: context
                                  //         .read<Profile>()
                                  //         .getCurrentID())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  return GridView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      var docid = snapshot.data!.docs[index].id;
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<Productprovider>()
                                              .setselctproduct(docid);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DataInImage()),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Image.network(
                                                        data['url'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF344D67),
                                                            ),
                                                      ),
                                                      Text(
                                                        '${data['price']} Bath',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF344D67),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      color: Color(0xFF7B8FA1),
      width: double.infinity,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
