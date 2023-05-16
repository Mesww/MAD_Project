import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mutu/Pages/circle.dart';
import 'package:mutu/provider/imagewelcome.dart';
import 'package:mutu/widgets/welcomegrid.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            child: TextField(
                style: TextStyle(color: Color(0xFF567189)),
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
                    itemCount:
                        context.watch<Imagewelcome>().images_bestseller.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = context
                          .watch<Imagewelcome>()
                          .images_bestseller[index];
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          context.read<Imagewelcome>().setactiveIndex(index),
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
                        height: 12,
                      ),
                      Welcomegrid(),
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
