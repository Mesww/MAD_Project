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
  final images = [
    'https://images.pexels.com/photos/3183197/pexels-photo-3183197.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/3184418/pexels-photo-3184418.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/3186654/pexels-photo-3186654.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  int activeIndex = 0;
  final List _category = [
    'cat 1',
    'cat 2',
    'cat 3',
    'cat 4',
    'cat 5',
    'cat 6',
    'cat 7',
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
                                itemCount: images.length,
                                itemBuilder: ((context, index, realIndex) {
                                  final image = images[index];
                                  return buildImages(image, index);
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
                            buildIndicator(),
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
                          height: 200,
                          width: 200,
                          color: Color(0xFF7B8FA1),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 200,
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

  Widget buildImages(String image, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        color: Color(0xFFCFB997),
        width: double.infinity,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: SlideEffect(
          dotColor: Color(0xFFCFB997),
          activeDotColor: Color(0xFFFAD6A5),
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
