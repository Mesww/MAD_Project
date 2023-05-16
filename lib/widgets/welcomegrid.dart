import 'package:flutter/material.dart';

class Welcomegrid extends StatefulWidget {
  const Welcomegrid({Key? key}) : super(key: key);

  @override
  _WelcomegridState createState() => _WelcomegridState();
}

class _WelcomegridState extends State<Welcomegrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12)),
          );
        });
  }
}
