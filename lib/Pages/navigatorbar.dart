import 'package:flutter/material.dart';
import 'package:mutu/Pages/chat.dart';
import 'package:mutu/Pages/userprofile.dart';
import 'package:mutu/Pages/sale.dart';
import 'package:mutu/Pages/welcome.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({Key? key}) : super(key: key);

  @override
  _NavigatorbarState createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  final screen = [Welcome(), Sale(), Userprofile()];

  final items = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.shopping_cart,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    )
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Theme.of(context).primaryColor,
        items: items,
        index: index,
        color: Color(0xFFCFB997),
        onTap: (selectIndex) {
          setState(() {
            index = selectIndex;
          });
        },
        height: 50,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationDuration: const Duration(milliseconds: 300),
        // animationCurve: ,
      ),
    );
  }
}
