import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final String child;
  Circle({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColor),
        child: Center(
            child: Text(
          child,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Color(0xFF344D67)),
        )),
      ),
    );
  }
}
