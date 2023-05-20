import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';

class Personnalinfo extends StatefulWidget {
  const Personnalinfo({Key? key}) : super(key: key);

  @override
  _PersonnalinfoState createState() => _PersonnalinfoState();
}

class _PersonnalinfoState extends State<Personnalinfo> {
  final formkey = GlobalKey<FormState>();
  Profile user = Profile();
  Map<String, dynamic> alldata = {};
  String name = '';
  String email = '';
  String age = '';
  String about = '';
  String uid = '';
  late XFile imagesprofile;
  late XFile imagesbackground;
  late File selectimagepathprofile;
  late File selectimagepathbackground;

  Future uploadFileprofile() async {
    final pathprofile = 'pictures/product/${imagesprofile!.name}';
    final imageprofile = File(selectimagepathprofile!.path);
    final refprofile = FirebaseStorage.instance.ref().child(pathprofile);
    setState(() {
      uploadTaskprofile = refprofile.putFile(imageprofile);
    });

    final snapshotprofile = await uploadTaskprofile!.whenComplete(() {});

    final urlDownloadsprofile =
        await snapshotprofile.ref.getDownloadURL().then((value) {
      updateData('urlprofile', value);
    });
    // print(urlDownloads);

    setState(() {
      uploadTaskprofile = null;
    });
  }

  Future uploadFilebackground() async {
    final pathbackground = 'pictures/product/${imagesbackground!.name}';
    final imagebackground = File(selectimagepathbackground!.path);
    final refbackground = FirebaseStorage.instance.ref().child(pathbackground);
    setState(() {
      uploadTaskbackground = refbackground.putFile(imagebackground);
    });

    final snapshotbackground = await uploadTaskbackground!.whenComplete(() {});

    final urlDownloadbackground =
        await snapshotbackground.ref.getDownloadURL().then((value) {
      updateData('urlbackground', value);
    });
    // print(urlDownloads);

    setState(() {
      uploadTaskbackground = null;
    });
  }

  Future updateData(String key, String newText) async {
    final documentReference = FirebaseFirestore.instance
        .collection('user')
        .doc(context.read<Profile>().getCurrentID());

    documentReference.update({
      key: newText,
    });
  }

  UploadTask? uploadTaskprofile;
  UploadTask? uploadTaskbackground;
  Future<void> _getdata(BuildContext context) async {
    final productProvider = context.read<Profile>();
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(productProvider.getCurrentID())
        .get();
    if (snapshot.exists) {
      setState(() {
        alldata = snapshot.data()!;
        name = snapshot.data()!['name'];
        email = snapshot.data()!['email'];
        age = snapshot.data()!['age'];
        about = snapshot.data()!['about'];
        uid = snapshot.data()!['uid'];
        data.addAll([name, email, age, about]);
        controller.addAll([
          TextEditingController(text: name),
          TextEditingController(text: email),
          TextEditingController(text: age),
          TextEditingController(text: about),
        ]);
      });
    }
  }

  List<String> data = [];
  List<String> title = ['name', 'email', 'age', 'about'];
  List<TextEditingController> controller = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getdata(context);
    });
  }

  void clear(int index) {
    controller[index].clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(context.read<Profile>().getCurrentID())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final userData = snapshot.data!.data() as Map;
                String? name;
                String? email;
                String? age;
                String? about;
                String? imageprofilepath;
                String? imagebackgroundpath;
                try {
                  name = userData['name'] as String?;
                  email = userData['email'] as String?;
                  age = userData['age'] as String?;
                  about = userData['about'] as String?;
                  imageprofilepath = userData['urlprofile'] as String;
                  imagebackgroundpath = userData['urlbackground'] as String;
                  data.clear();
                  data.addAll([name!, email!, age!, about!]);
                } catch (e) {
                  // Handle any casting errors here
                  print('Error: $e');
                }
                return Column(children: [
                  Stack(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Stack(alignment: Alignment.bottomRight, children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              margin: EdgeInsets.only(bottom: 40),
                              height: 150,
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  imagebackgroundpath!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: IconButton(
                                    onPressed: () {
                                      selectImagebackground().then((value) {
                                        uploadFilebackground();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                    )),
                              ),
                            )
                          ]),
                          Stack(alignment: Alignment.bottomRight, children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  imageprofilepath!),
                              radius: 40,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            IconButton(
                                onPressed: () {
                                  selectImageprofile().then((value) {
                                    uploadFileprofile();
                                  });
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                ))
                          ]),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Navigatorbar())),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          child: SizedBox(
                            height: 40,
                            width: 100,
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: title.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                '${title[index]} : ${data[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor),
                              ),
                              trailing: title[index] == 'email'
                                  ? Text('')
                                  : IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .appBarTheme
                                                  .backgroundColor,
                                              title: Text(
                                                '${title[index]}'.toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              content: TextFormField(
                                                controller: controller[index],
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  child: Text(
                                                    'CANCEL',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .appBarTheme
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  child: Text(
                                                    'OK',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .appBarTheme
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  onPressed: () async {
                                                    await updateData(
                                                      title[index],
                                                      controller[index].text,
                                                    ).then((value) {
                                                      clear(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ]);
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Future selectImageprofile() {
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
                              pickImageprofile(ImageSource.gallery);
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
                              pickImageprofile(ImageSource.camera);
                              if (selectimagepathprofile != '') {
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

  Future selectImagebackground() {
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
                              pickImagebackground(ImageSource.gallery);
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
                              pickImagebackground(ImageSource.camera);
                              if (selectimagepathbackground != '') {
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

  Future pickImageprofile(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      final ImageTemporary = File(image!.path);
      setState(() {
        imagesprofile = image;
        selectimagepathprofile = ImageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImagebackground(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      final ImageTemporary = File(image!.path);
      setState(() {
        imagesbackground = image;
        selectimagepathbackground = ImageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildProgressProfile() => StreamBuilder<TaskSnapshot>(
      stream: uploadTaskprofile?.snapshotEvents,
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
  Widget buildProgressbackground() => StreamBuilder<TaskSnapshot>(
      stream: uploadTaskbackground?.snapshotEvents,
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
}
