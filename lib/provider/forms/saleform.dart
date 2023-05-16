import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saleform extends ChangeNotifier {
  
  String name = '';
  String detail = '';
  String category = '';
  int price = 0;
  String brand = '';
  String color = '';
  String durability = '';
  String urldownload = '';

  String get getname => name;
  String get getdetail => detail;
  String get getcategory => category;
  int get getprice => price;
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

  void set_price(int price) {
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
