import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Welcomeprovider extends ChangeNotifier {
    
  final images_bestseller = [
    'https://media.istockphoto.com/id/1309042044/photo/interior-design-of-stylish-dining-room-interior-with-family-wooden-table-modern-chairs-plate.jpg?b=1&s=170667a&w=0&k=20&c=L1uZ3qcVPS19aTnjjLU-3nFAtbaL6Yq-BLkdcvG9gMs=',
    'https://images.pexels.com/photos/3521937/pexels-photo-3521937.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2762247/pexels-photo-2762247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/221004/pexels-photo-221004.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2112638/pexels-photo-2112638.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  final images_recommend = [
    'https://images.pexels.com/photos/214487/pexels-photo-214487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/14540966/pexels-photo-14540966.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/240225/pexels-photo-240225.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2333855/pexels-photo-2333855.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  int activeIndex = 0;
  void setactiveIndex(int activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }

  
}
