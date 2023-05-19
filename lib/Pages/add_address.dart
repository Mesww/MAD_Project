import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/address.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editAddress extends StatefulWidget {
  const editAddress({Key? key}) : super(key: key);

  @override
  _editAddressState createState() => _editAddressState();
}

class _editAddressState extends State<editAddress> {
  final firebase_sale = FirebaseFirestore.instance.collection('products');
  final useraddress = FirebaseFirestore.instance.collection('useraddress');
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Navigatorbar()));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(width: 100.0),
              Text(
                'ที่อยู่',
                style: TextStyle(color: const Color(0xFFFFAD6A5)),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  'ช่องทางการติดต่อ',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFAD6A5)),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFAD6A5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    // onSaved: Address,
                    decoration: InputDecoration(
                      hintText: 'กรอกชื่อ-นามสกุล-เบอร์โทร',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'ข้อมูลการจัดส่งสินค้า',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFAD6A5)),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFAD6A5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'กรอกข้อมูลการจัดส่งสินค้า',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'จังหวัด',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFAD6A5)),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFAD6A5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'จังหวัด',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'อำเภอ',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFAD6A5)),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFAD6A5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'อำเภอ',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'รหัสไปรษณีย์',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFAD6A5)),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFAD6A5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'รหัสไปรษณีย์',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Address(),
                      ));
                    },
                    child: Text(
                      'เพิ่มที่อยู่',
                      style: TextStyle(color: Color(0xFF344D67)),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFFAD6A5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
