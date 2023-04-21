import 'package:flutter/material.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/Pages/payment/bank.dart';
import 'package:mutu/Pages/payment/credic.dart';
import 'package:mutu/Pages/payment/prompay.dart';
import 'package:mutu/Pages/payment/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Prompay(),
    Credic(),
  ];
  List<IconData> icons = [Icons.money, Icons.book, Icons.credit_card];

  List<String> titles = ['Bank', 'Prompay', 'Credic'];

  int indexPosition = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  void initState() {
    super.initState();

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems
          .add(createBottomNavigationBarItem(icons[i], item));
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Wallet from ${titles[indexPosition]}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 20)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Navigatorbar())));
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: MyConstant.dark),
        unselectedIconTheme: IconThemeData(color: MyConstant.light),
        selectedItemColor: MyConstant.dark,
        unselectedItemColor: MyConstant.light,
        items: bottomNavigationBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
