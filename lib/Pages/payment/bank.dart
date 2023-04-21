import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mutu/Pages/payment/my_constant.dart';
import 'package:mutu/Pages/payment/nav_confirm_add_wallet.dart';
import 'package:mutu/Pages/payment/show_title.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTitle(),
          buildBKKbank(),
          buildKbank(),
        ],
      ),
      floatingActionButton: NavConfirmAddWallet(),
    );
  }

  Widget buildBKKbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.indigo.shade100,
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/bbl.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกรุงเทพ สาขามหาวิทยาลัยแม่ฟ้าหลวง',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นายสมหญิง ยาวจัด เลขบัญชี  123 - 4 - 56789 - 0',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }

  Container buildKbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.green[100],
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/kbank.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกสิกรไทย สาขามหาวิทยาลัยแม่ฟ้าหลวง',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นายสมหญิง ยาวจัด เลขบัญชี  123 - 4 - 56789 - 0',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }
}

class buildTitle extends StatelessWidget {
  const buildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
          title: 'การโอนเงินเข้า บัญชีธนาคาร',
          textStyle: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
