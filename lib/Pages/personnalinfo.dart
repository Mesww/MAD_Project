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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<Profile>().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Stack(alignment: Alignment.bottomCenter, children: <Widget>[
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
                ]),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Navigatorbar())));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    )),
              ]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              alignment: Alignment.center,
                              color: Theme.of(context).primaryColor,
                              width: 100,
                              height: 50,
                              child: Text(
                                'Edit',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          readOnly: true,
                          enabled: false,
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                                  labelText: '${snapshot.data.email}')
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          readOnly: true,
                          enabled: false,
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(labelText: '*******')
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Name')
                              .applyDefaults(Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'About',
                        ).applyDefaults(Theme.of(context)
                            .inputDecorationTheme
                            .copyWith(
                                labelStyle:
                                    Theme.of(context).textTheme.headlineSmall)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                        ).applyDefaults(Theme.of(context)
                            .inputDecorationTheme
                            .copyWith(
                                labelStyle:
                                    Theme.of(context).textTheme.headlineSmall)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 150,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            'Ok',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Color(0xFF344D67), fontSize: 15),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
