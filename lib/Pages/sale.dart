import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutu/provider/forms/saleform.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  final formkey = GlobalKey<FormState>();
  Saleform formsale = Saleform();

  var images;
  File? selectimagepath;
  List<String> items_cat = ['Clothes', 'Furniture', 'Electronic', 'Watch'];
  List<String> items_status = ['very good', 'good', 'bad', 'fair'];
  var select_item_cat = null;
  var select_item_status = null;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference salecollection =
      FirebaseFirestore.instance.collection('products');
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  selectimagepath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: GestureDetector(
                              child: Image.file(selectimagepath!),
                              onTap: () {
                                selectImage();
                              },
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () async {
                            selectImage();
                          },
                          child: Text(
                            'Add Photo',
                            style: Theme.of(context).textTheme.headlineLarge,
                          )),
                  SizedBox(
                    height: 40,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(
                        errorText: 'Please input name of your product'),
                    onSaved: (String? name) {
                      formsale.set_name(name!);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(
                        errorText: 'Please input detail of your product'),
                    onSaved: (String? detail) {
                      formsale.set_detail(detail!);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Detail',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      validator: (value) => value == null
                          ? 'Please select category of your product'
                          : null,
                      hint: Text(
                        'Category',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      dropdownColor: Color(0xFF7B8FA1),
                      value: select_item_cat,
                      items: items_cat
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall)))
                          .toList(),
                      onChanged: (item) => setState(() {
                        select_item_cat = item!;
                      }),
                      onSaved: (String? category) {
                        formsale.set_category(category!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please input price of your product'),
                      PatternValidator(r'^([0-9])+$',
                          errorText: 'Only numberic')
                    ]),
                    onSaved: (String? price) {
                      formsale.set_price(int.tryParse(price!)!);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(
                        errorText: 'Please input brand of your product'),
                    onSaved: (String? brand) {
                      formsale.set_brand(brand!);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Brand',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(
                        errorText: 'Please input color of your product'),
                    onSaved: (String? color) {
                      formsale.set_color(color!);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Color',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      validator: (value) => value == null
                          ? 'Please select durability of your product'
                          : null,
                      hint: Text(
                        'Durability',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      dropdownColor: Color(0xFF7B8FA1),
                      value: select_item_status,
                      items: items_status
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall)))
                          .toList(),
                      onChanged: (item) => setState(() {
                        select_item_status = item!;
                      }),
                      onSaved: (String? durability) {
                        formsale.set_durability(durability!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        // await salecollection.add({
                        //   'name': formsale.getname,
                        //   'detail': formsale.getdetail,
                        //   'category': formsale.category,
                        //   'price': formsale.getprice,
                        //   'brand': formsale.getbrand,
                        //   'color': formsale.getcolor,
                        //   'durability': formsale.getdurability,
                        //   'userid': Provider.of(context).auth?.getCurrentID()
                        // });
                        // print(formsale.getname);
                        // print(formsale.getprice);
                        // print(formsale.getdetail);
                        // print(formsale.getcategory);
                        // print(formsale.getbrand);
                        // print(formsale.getcolor);
                        // print(formsale.getdurability);
                        // print(Provider.of(context).auth?.getCurrentID());
                        uploadFile();
                        formkey.currentState!.reset();
                        setState(() {
                          select_item_cat = null;
                          select_item_status = null;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'Save',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Color(0xFF344D67), fontSize: 15),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildProgress()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: ((context) => Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        'Select Image From',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              pickImage(ImageSource.gallery);
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Icon(
                                          Icons.browse_gallery,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    Text(
                                      'Gallery',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              pickImage(ImageSource.camera);
                              if (selectimagepath != '') {
                                Navigator.pop(context);
                                //add image to database
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'No Image Selected',
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Color(0xFFFAD6A5),
                                    textColor: Color(0xFF344D67));
                              }
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    Text(
                                      'Camera',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Future uploadFile() async {
    final path = 'pictures/product/${images!.name}';
    final image = File(selectimagepath!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(image);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownloads = await snapshot.ref.getDownloadURL().then((value) {
      salecollection.add({
        'name': formsale.getname,
        'detail': formsale.getdetail,
        'category': formsale.category,
        'price': formsale.getprice,
        'brand': formsale.getbrand,
        'color': formsale.getcolor,
        'durability': formsale.getdurability,
        'userid': context.read<Profile>().getCurrentID(),
        'url': value
      });
    });
    // print(urlDownloads);

    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 50,
          );
        }
      });

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      final ImageTemporary = File(image!.path);
      setState(() {
        images = image;
        selectimagepath = ImageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
