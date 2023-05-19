import 'package:flutter/material.dart';
import 'package:mutu/Pages/my_store.dart';
import 'package:mutu/Pages/welcome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mutu/Pages/chat.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF567189),
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Welcome(),
                    ));
              },
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MyStore()));
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.shoppingBasket,
                    color: Theme.of(context).primaryColor,
                  ))
            ]),
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                        width: 250,
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(13),
                            child: Container(
                              height: 220,
                              //ใส่รูปดึงจากfirebase กูดึงไม่เป็น
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: AssetImage("")),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Description"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat()),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Chat',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Color(0xFF344D67),
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // Right button action
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Purchase',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Color(0xFF344D67),
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]
          ),
        ));
  }
}



