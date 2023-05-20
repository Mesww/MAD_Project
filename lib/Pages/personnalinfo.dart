import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Map alldata = {};
  String name = '';
  String email = '';
  String age = '';
  String about = '';
  String uid = '';

  Future updateData(String key, String newText) async {
    final documentReference = FirebaseFirestore.instance
        .collection('user')
        .doc(context.read<Profile>().getCurrentID());

    documentReference.update({
      key: newText,
    });
  }

  Future<void> _getdata(BuildContext context) async {
    final productProvider = context.read<Profile>();
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(productProvider.getCurrentID())
        .get();
    if (snapshot.exists) {
      setState(() {
        debugPrint('${snapshot.data()}');
        alldata = snapshot.data()!;
        name = snapshot.data()!['name'];
        email = snapshot.data()!['email'];
        age = snapshot.data()!['age'];
        about = snapshot.data()!['about'];
        uid = snapshot.data()!['uid'];
        debugPrint(name);
      });
    }
  }

  List<String> data = [];
  List title = ['name', 'email', 'age', 'about'];
  TextEditingController name_ = TextEditingController();
  TextEditingController email_ = TextEditingController();
  TextEditingController age_ = TextEditingController();
  TextEditingController about_ = TextEditingController();
  List<TextEditingController> controller = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getdata(context);
      data.addAll([name, email, age, about]);
      controller.addAll([name_, email_, age_, about_]);
    });
  }

  void clear(int index) {
    controller[index].clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.only(bottom: 40),
                      height: 150,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148907303.jpg?w=740&t=st=1681908736~exp=1681909336~hmac=5fdb1fbeecaf7427a7f2272c512478f9f439189687c9c4bfd9b1a9b2f9f6a2fc',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://icons.iconarchive.com/icons/iconarchive/cute-animal/256/Cute-Cat-icon.png'),
                      radius: 40,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: ((context) => Navigatorbar())),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
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
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return Card(
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
                    trailing: IconButton(
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
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                content: TextFormField(
                                  controller: controller[index],
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: Text('CANCEL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .backgroundColor,
                                                fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor),
                                    child: Text('OK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .backgroundColor,
                                                fontWeight: FontWeight.bold)),
                                    onPressed: () async {
                                      await updateData('${title[index]}',
                                          controller[index].text);
                                      clear(index);
                                      // do something with the text
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
