import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final String child;
  Circle({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Image.network(
            child,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
