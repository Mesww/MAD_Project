import 'package:flutter/material.dart';
import 'package:mutu/Pages/navigatorbar.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Navigatorbar(),
              ));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
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
                      'Your Address',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Color(0xFF344D67), fontSize: 15),
                    )),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 150,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                'Add',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Color(0xFF344D67), fontSize: 15),
                              ),
                            ],
                          )),
                        ),
                      )),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
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
                                'Confirm',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Color(0xFF344D67), fontSize: 15),
                              )),
                            ),
                          )),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
