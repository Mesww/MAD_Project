import 'package:flutter/material.dart';

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  List<String> items_cat = ['Clothes', 'Furniture', 'Electronic', 'Watch'];
  List<String> items_status = ['very good', 'good', 'bad', 'fair'];
  String select_item_cat = 'Clothes';
  String select_item_status = 'fair';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: () {},
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
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Detail',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                      dropdownColor: Color(0xFF7B8FA1),
                      value: select_item_cat,
                      items: items_cat
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.black, fontSize: 15))))
                          .toList(),
                      onChanged: (item) => setState(() {
                            select_item_cat = item!;
                          })),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Brand',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Color',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                      dropdownColor: Color(0xFF7B8FA1),
                      value: select_item_status,
                      items: items_status
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.black, fontSize: 15))))
                          .toList(),
                      onChanged: (item) => setState(() {
                            select_item_status = item!;
                          })),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
