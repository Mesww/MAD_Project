import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutu/Pages/navigatorbar.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextField(
            style: TextStyle(color: Color(0xFF567189)),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Color(0xFFFAD6A5),
              hintText: "Search",
              hintStyle: TextStyle(color: Color(0xFFFAD6A5)),
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: ((context) => Navigatorbar())),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFFAD6A5),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                if (name.isEmpty) {
                  return Card(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 100,
                          width: 50,
                          child: Image.network(
                            data['url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        data['name'],
                        style: Theme.of(context).textTheme.headlineSmall!,
                      ),
                      subtitle: Text(data['category'],
                          style: Theme.of(context).textTheme.headlineSmall!),
                      trailing: Text('${data['price']}  baht',
                          style: Theme.of(context).textTheme.headlineSmall!),
                    ),
                  );
                }
                if (data['name']
                    .toString()
                    .toLowerCase()
                    .contains(name.toLowerCase())) {
                  return ListTile(
                    leading: Image.network(data['url']),
                    title: Text(data['name']),
                    subtitle: Text(data['category']),
                  );
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
