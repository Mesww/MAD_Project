import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saleform extends ChangeNotifier {
  List<String> items_cat = [
    'Clothes',
    'Furniture',
    'Electronic',
    'Watch',
    'Book',
    'Skirt',
    'Shoes',
    'Bag',
    'Accessories',
    'Musical',
    'Other'
  ];

  List<String> items_status = ['very good', 'good', 'bad', 'fair'];
  String name = '';
  String detail = '';
  String category = '';
  String price = '';
  String brand = '';
  String color = '';
  String durability = '';
  String urldownload = '';

  void add_items_cat(String items_cat) {
    this.items_cat.add(items_cat);
  }

  void add_items_status(String items_status) {
    this.items_status.add(items_status);
  }

  List<String> get getitems_cat => items_cat;
  List<String> get getitems_status => items_status;
  String get getname => name;
  String get getdetail => detail;
  String get getcategory => category;
  String get getprice => price;
  String get getbrand => brand;
  String get getcolor => color;
  String get getdurability => durability;
  String get geturldownload => urldownload;

  void set_name(String name) {
    this.name = name;
    notifyListeners();
  }

  void set_detail(String detail) {
    this.detail = detail;
    notifyListeners();
  }

  void set_category(String category) {
    this.category = category;
    notifyListeners();
  }

  void set_price(String price) {
    this.price = price;
    notifyListeners();
  }

  void set_brand(String brand) {
    this.brand = brand;
    notifyListeners();
  }

  void set_color(String color) {
    this.color = color;
    notifyListeners();
  }

  void set_durability(String durability) {
    this.durability = durability;
    notifyListeners();
  }

  void set_urldownload(String urldownload) {
    this.urldownload = urldownload;
    notifyListeners();
  }
}
