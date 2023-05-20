import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productprovider extends ChangeNotifier {
  String selectproduct = '';
  void setselctproduct(String selectproduct) {
    this.selectproduct = selectproduct;
  }

  Icon icon = Icon(
    Icons.favorite_outlined,
    size: 19.0,
  );

  Widget label = Text('');

  void setlabel(Widget label) {
    this.label = label;
  }

  void setcoloricon(Color color) {
     icon = Icon(Icons.favorite_outlined, color: color, size: 19.0);
  }

  Widget get getlabel => label;

  Icon get geticon => icon;

  String get getselectproduct => selectproduct;
}
