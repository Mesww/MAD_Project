import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mutu/Pages/circle.dart';
import 'package:mutu/Pages/square.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final images_bestseller = [
    'https://media.istockphoto.com/id/1309042044/photo/interior-design-of-stylish-dining-room-interior-with-family-wooden-table-modern-chairs-plate.jpg?b=1&s=170667a&w=0&k=20&c=L1uZ3qcVPS19aTnjjLU-3nFAtbaL6Yq-BLkdcvG9gMs=',
    'https://images.pexels.com/photos/3521937/pexels-photo-3521937.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2762247/pexels-photo-2762247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/221004/pexels-photo-221004.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2112638/pexels-photo-2112638.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  final images_recommend = [
    'https://images.pexels.com/photos/214487/pexels-photo-214487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/14540966/pexels-photo-14540966.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/240225/pexels-photo-240225.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2333855/pexels-photo-2333855.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  int activeIndex = 0;
  final List _category = [
    //table
    'https://images.pexels.com/photos/2451264/pexels-photo-2451264.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //phone
    'https://images.pexels.com/photos/1647976/pexels-photo-1647976.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //cloth
    'https://images.pexels.com/photos/1502216/pexels-photo-1502216.jpeg?auto=compress&cs=tinysrgb&w=400',
    //watch
    'https://images.pexels.com/photos/110471/pexels-photo-110471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //jean
    'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //pan
    'https://images.pexels.com/photos/1128426/pexels-photo-1128426.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //brush
    'https://images.pexels.com/photos/973402/pexels-photo-973402.jpeg?auto=compress&cs=tinysrgb&w=400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF567189),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                    style: TextStyle(color: Color(0xFF567189)),
                    decoration: InputDecoration(
                            labelText: "Search",
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Theme.of(context).primaryColor)
                        .applyDefaults(Theme.of(context)
                            .inputDecorationTheme
                            .copyWith(
                                labelStyle:
                                    Theme.of(context).textTheme.headlineSmall))
                    // InputDecoration(
                    //   filled: true,
                    //   fillColor: Color(0xFFCFB997),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     borderSide: BorderSide.none,
                    //   ),
                    //   hintText: "Search",
                    //   prefixIcon: Icon(Icons.search),
                    //   prefixIconColor: Color(0xFF7B8FA1),
                    // ),
                    ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      color: Color(0xFF7B8FA1),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _category.length,
                        itemBuilder: (context, index) {
                          return Circle(
                            child: _category[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: ListView(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Color(0xFF7B8FA1),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Best Seller',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CarouselSlider.builder(
                                itemCount: images_bestseller.length,
                                itemBuilder: ((context, index, realIndex) {
                                  final image_bestseller =
                                      images_bestseller[index];
                                  return buildImagesbestseller(
                                      image_bestseller, index);
                                }),
                                options: CarouselOptions(
                                  // viewportFraction: 1,
                                  height: 200,
                                  pageSnapping: false,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  autoPlay: true,
                                  // reverse: true,
                                  autoPlayInterval: Duration(seconds: 2),
                                  onPageChanged: (index, reason) =>
                                      setState(() => activeIndex = index),
                                )),
                            SizedBox(
                              height: 22.0,
                            ),
                            buildIndicatorbestseller(),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Recommend',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CarouselSlider.builder(
                                itemCount: images_recommend.length,
                                itemBuilder: ((context, index, realIndex) {
                                  final image_recommend =
                                      images_recommend[index];
                                  return buildImagesreccommand(
                                      image_recommend, index);
                                }),
                                options: CarouselOptions(
                                  // viewportFraction: 1,
                                  height: 200,
                                  pageSnapping: false,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  autoPlay: true,
                                  // reverse: true,
                                  autoPlayInterval: Duration(seconds: 2),
                                  onPageChanged: (index, reason) =>
                                      setState(() => activeIndex = index),
                                )),
                            SizedBox(
                              height: 22.0,
                            ),
                            buildIndicatorreccommand(),
                          ]),
                          height: 300,
                          width: 200,
                          color: Color(0xFF7B8FA1),
                        ))
                  ]),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildImagesbestseller(String image, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        color: Color(0xFFCFB997),
        width: double.infinity,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );

  Widget buildImagesreccommand(String image, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        color: Color(0xFFCFB997),
        width: double.infinity,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
  Widget buildIndicatorbestseller() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images_bestseller.length,
        effect: SlideEffect(
          dotColor: Color(0xFFCFB997),
          activeDotColor: Color(0xFFFAD6A5),
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
  Widget buildIndicatorreccommand() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images_recommend.length,
        effect: SlideEffect(
          dotColor: Color(0xFFCFB997),
          activeDotColor: Color(0xFFFAD6A5),
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
