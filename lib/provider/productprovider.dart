import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productprovider extends ChangeNotifier {
  String selectproduct = '';
  void setselctproduct(String selectproduct) {
    this.selectproduct = selectproduct;
  }

   Widget label = Text('');

  void setlabel(Widget label) {
    this.label = label;
  }

  Widget get getlabel => label;

  String get getselectproduct => selectproduct;
}
