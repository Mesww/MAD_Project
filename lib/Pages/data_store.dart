import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/provider/productprovider.dart';
import 'package:mutu/provider/profile.dart';
import 'package:provider/provider.dart';

class DataInImage extends StatefulWidget {
  const DataInImage({Key? key}) : super(key: key);
  @override
  State<DataInImage> createState() => _DataInImageState();
}

class _DataInImageState extends State<DataInImage> {
  final auth = FirebaseAuth.instance;

  final List<String> images = [];
  String name = '';
  String detail = '';
  String category = '';
  String brand = '';
  String color = '';
  String durability = '';
  String? userid = '';
  String url = '';
  String price = '';
  bool checkfav = false;

  String _selectedProduct = '';

  Map<String, String> details = {'detail': ''};
  Map<String, dynamic> alldata = {};
  final _collectionRef = FirebaseFirestore.instance.collection('products');
  Future<void> _getdata(BuildContext context) async {
    final productProvider = context.read<Productprovider>();
    final selectedProduct = productProvider.getselectproduct;
    if (selectedProduct.isNotEmpty && selectedProduct.isNotEmpty) {
      debugPrint(selectedProduct);

      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(selectedProduct)
          .get();

      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        setState(() {
          _selectedProduct = selectedProduct;
          debugPrint('${snapshot.data()}');
          alldata = snapshot.data()!;
          name = snapshot.data()!['name'];
          detail = snapshot.data()!['detail'];
          category = snapshot.data()!['category'];
          userid = snapshot.data()!['userid'];
          url = snapshot.data()!['url'];
          price = snapshot.data()!['price'];
          debugPrint('${checkfav}');
          // debugPrint(
          //     '${name} ${detail} ${category} ${userid} ${url} ${price} ');
          productProvider.setlabel(Text("$price ฿",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(225, 38, 71, 100),
              )));
          details.clear();
          details = {
            "Brand": "${snapshot.data()!['brand']}",
            "Status": "${snapshot.data()!['durability']}",
            "Color": "${snapshot.data()!['color']}",
          };
          images.add(url);
        });
      }
    }
  }

  @override
  void initState() {
    _getdata(context);
    super.initState();
  }

  final fav = FirebaseFirestore.instance.collection('fav');
  final cart = FirebaseFirestore.instance.collection('cart');
  Future<void> deleteSubcollection(String? parentDocumentId) async {
    CollectionReference subCollectionRef =
        fav.doc(parentDocumentId!).collection('data');

    QuerySnapshot querySnapshot = await subCollectionRef.get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const secondaryColor = Color.fromARGB(226, 123, 143, 161);
    final String prices = price;
    // debugPrint(price);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Navigatorbar()));
          },
        ),
        backgroundColor: const Color(0xFFCFB997),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AboutDialog(
                        children: [],
                      ));
            }, //<<ใส่ได้ กดไอคอนแล้วสินค้าจะเพิ่มในตะกร้า
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.message, size: 19.0),
                    label: const Text("Send Message"), //ปุ่มด้านล่าง
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: primaryColor,
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cart')
                      .where('idproduct', isEqualTo: _selectedProduct)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      CircularProgressIndicator();
                    }
                    return Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          height: 35,
                          width: 200,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add_shopping_cart_rounded,
                                size: 19.0),
                            label: const Text("Add to cart"), //ปุ่มด้านล่าง
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text('Add to cart'),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: Text(
                                              'CANCEL',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .appBarTheme
                                                        .backgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                cart.doc(_selectedProduct).set({
                                                  'uid': context
                                                      .read<Profile>()
                                                      .getCurrentID(),
                                                  'idproduct': _selectedProduct,
                                                }).then((value) {
                                                  cart
                                                      .doc(_selectedProduct)
                                                      .collection('data')
                                                      .add(alldata)
                                                      .then((value) {
                                                    _collectionRef
                                                        .doc(_selectedProduct)
                                                        .update({
                                                      'stage': false
                                                    }).then((value) => Navigator
                                                            .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Navigatorbar())));
                                                  });
                                                });
                                              },
                                              child: Text('OK'))
                                        ],
                                      )));
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // User profile banner
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(userid!)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final data = snapshot.data!.data() as Map;

                        return ShopBanner(
                          avatarImage: NetworkImage(
                            data['urlprofile']!,
                          ),
                          title: Text(
                            'Profile of ${data['name']!}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCFB997),
                            ),
                          ),
                          subtitle: Text(
                            '** SCORE **',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFCFB997),
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),

                const SizedBox(
                  height: 8,
                ),
                // Text(price),
                // Product Box
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('fav')
                        .where('idproduct', isEqualTo: _selectedProduct)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ProductSlideBox(
                        label: Text("$prices ฿",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(225, 38, 71, 100),
                            )),
                        images: images,
                        onFavorite: () {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            CircularProgressIndicator();
                          } else {
                            //bugfavorite
                            if (snapshot.data!.docs.isNotEmpty) {
                              context.read<Productprovider>().setcoloricon(
                                  Color.fromARGB(226, 123, 143, 161));
                              setState(() {
                                checkfav = false;
                                debugPrint('$checkfav');
                              });
                              fav.doc(_selectedProduct).delete().then(
                                (value) {
                                  deleteSubcollection(_selectedProduct);
                                  debugPrint('unlike');
                                },
                              );
                            } else {
                              context
                                  .read<Productprovider>()
                                  .setcoloricon(Theme.of(context).primaryColor);
                              setState(() {
                                checkfav = true;
                                debugPrint('$checkfav');
                              });
                              fav.doc(_selectedProduct).set({
                                'uid': context.read<Profile>().getCurrentID(),
                                'idproduct': _selectedProduct,
                              }).then((value) {
                                fav
                                    .doc(_selectedProduct)
                                    .collection('data')
                                    .add(alldata);
                              });
                              debugPrint('like');
                            }
                          }
                        },
                      );
                    }),

                const SizedBox(
                  height: 8,
                ),

                ProductDetailsBox(
                  title: "Product detail",
                  description: "${detail}",
                  details: details,
                ),

                Container(
                  width: double.infinity,
                  //padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    //color: secondaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              'Products from this store.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 161, 192, 206),
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Show all',
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('products')
                                .where('userid', isEqualTo: userid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  final image = data['url']!;

                                  return _selectedProduct !=
                                          snapshot.data!.docs[index].id
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 1),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<Productprovider>()
                                                  .setselctproduct(snapshot
                                                      .data!.docs[index].id);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DataInImage()));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.network(
                                                  image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

/// Product details box
class ProductDetailsBox extends StatelessWidget {
  /// product [title] on the top
  final String title;

  /// product [description] below title
  final String description;

  /// the [details] of the product as pair display below description
  final Map<String, String> details;

  const ProductDetailsBox({
    super.key,
    required this.title,
    required this.description,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const secondaryColor = Color.fromARGB(225, 38, 71, 100);

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(2),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: secondaryColor.withAlpha(250),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // Product description
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              description, //<<Brand data
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: secondaryColor,
              ),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // Product details
          Builder(builder: (context) {
            final items = details.entries;
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 8,
              children: List.generate(items.length, (index) {
                final item = items.elementAt(index);
                return RichText(
                  text: TextSpan(
                    // Detail title
                    text: item.key,
                    // Detail title style
                    style: const TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(text: " : "),
                      TextSpan(
                        // Detail value
                        text: item.value,
                        // Detail value's style
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}

/// Shop Banner
class ShopBanner extends StatelessWidget {
  /// Avatar image at the left of banner
  final ImageProvider avatarImage;

  /// the title of the banner
  final Widget title;

  /// the subtitle of the banner
  final Widget subtitle;

  /// on follow button click function
  final void Function()? onFollow;

  /// A widget for display shop's banner
  ///
  /// Which have [avatarImage] of the shop,
  /// [title] for the shop name or any title
  /// and [subtitle] with score or any short description
  ///
  /// [onFollow] function can use when follow button is clicked
  const ShopBanner({
    super.key,
    required this.avatarImage,
    required this.title,
    required this.subtitle,
    this.onFollow,
  });

  /// Handler of [onFollow] function
  void _onFollowClick() {
    if (onFollow != null) {
      onFollow!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const secondaryColor = Color.fromARGB(226, 123, 143, 161);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      width: double.infinity,
      decoration: const BoxDecoration(
        // banner's container border
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(50),
        ),
        color: secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Profile avatar
          CircleAvatar(
            backgroundImage: avatarImage,
            radius: 20,
            backgroundColor: primaryColor,
          ),
          // User info and button
          Expanded(
            child: Row(
              children: [
                // User info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Title and Subtitle is here
                      children: [
                        title,
                        subtitle,
                      ],
                    ),
                  ),
                ),

                // Follow button
                ElevatedButton(
                  onPressed: _onFollowClick,
                  // Follow button style
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  // Follow button text
                  child: const Text(
                    'FOLLOW',
                    // Follow button text style
                    style: TextStyle(
                      color: Color(0xFF7B8FA1),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Product slide [images] box
class ProductSlideBox extends StatefulWidget {
  /// The list of [images] to show
  final List<String> images;

  /// [onFavorite] button click handler function
  final void Function()? onFavorite;

  /// [onShare] icon click handler function
  final void Function()? onShare;

  /// The [label] at the bottom left
  final Widget label;

  /// Product slide box
  ///
  /// Use to show slide [images] of the product
  /// with [label] at the bootom left.
  ///
  /// It can handle [onShare] icon click,
  /// and [onFavorite] button click.
  const ProductSlideBox({
    super.key,
    required this.images,
    required this.label,
    this.onFavorite,
    this.onShare,
  });

  @override
  State<ProductSlideBox> createState() => _ProductSlideBoxState();
}

/// Product slide box state
class _ProductSlideBoxState extends State<ProductSlideBox> {
  /// [_images] state
  late final List<String> _images;

  /// [_label] of the box at bottom left
  late final Widget _label;

  @override
  void initState() {
    _images = widget.images;
    _label = widget.label;
    super.initState();
  }

  /// Handle on favorite botton click
  void _onfavoriteClick() {
    if (widget.onFavorite != null) {
      widget.onFavorite!();
    }
  }

  /// Handle on share icon click
  void _onShareClick() {
    if (widget.onShare != null) {
      widget.onShare!();
    }
  }

  /// Build each image for slider
  Widget _buildImagesshop(String image, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: const Color(0xFFCFB997),
      width: double.infinity,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const secondaryColor = Color.fromARGB(226, 123, 143, 161);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF7B8FA1),
      ),
      child: Column(
        children: [
          // Images slide
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider.builder(
              itemCount: _images.length,
              itemBuilder: ((context, index, realIndex) {
                //pathbestseller
                final image = _images[index];
                return _buildImagesshop(image, index);
              }),
              options: CarouselOptions(
                height: 300,
                pageSnapping: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                scrollPhysics: const BouncingScrollPhysics(),
                initialPage: 0,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                autoPlay: false,
              ),
            ),
          ),
          // Product action
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              color: primaryColor,
            ),
            child: Row(
              children: [
                // Label is here
                context.read<Productprovider>().getlabel,

                // Actions
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Share icon
                      IconButton(
                        onPressed: _onShareClick,
                        icon: Icon(Icons.ios_share_outlined, size: 19),
                      ),

                      // Favorite Icon
                      ElevatedButton.icon(
                        icon: context.read<Productprovider>().geticon,
                        label: const Text("Favorite"),
                        onPressed: _onfavoriteClick,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: primaryColor,
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
