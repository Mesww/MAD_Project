import 'package:flutter/material.dart';

class Saleform {
  String name = '';
  String detail = '';
  String category = '';
  int price = 0;
  String brand = '';
  String color = '';
  String durability = '';
  String userid = '';
  String urldownload = '';

  void seturldownload(String urldownload) {
    this.urldownload = urldownload;
  }
  void setName(String name) {
    this.name = name;
  }

  void setdetail(String detail) {
    this.detail = detail;
  }

  void setcategory(String category) {
    this.category = category;
  }

  void setprice(int price) {
    this.price = price;
  }

  void setbrand(String brand) {
    this.brand = brand;
  }

  void setcolor(String color) {
    this.color = color;
  }

  void setdurability(String durability) {
    this.durability = durability;
  }

  void setuserid(String userid) {
    this.userid = userid;
  }

  String get geturldownload => urldownload;
  String get getname => name;
  String get getdetail => detail;
  String get getcategory => category;
  int get getprice => price;
  String get getbrand => brand;
  String get getcolor => color;
  String get getdurability => durability;
  String get getuserid => userid;
}
