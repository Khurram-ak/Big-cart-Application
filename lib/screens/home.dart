import 'package:ecommerce_app/Providers/CartProvider.dart';
import 'package:ecommerce_app/widgets/category.dart';
import 'package:ecommerce_app/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '../Models/AllCategories.dart';
import '../Models/AllProducts.dart';
import '../Providers/AuthProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool qtyDisplay = false;

  AllCategories? _allCategories;
  List<Category>? category;
  List<Product>? product;

  Future GetCategories(accessToken) async {
    var url = Uri.parse('http://ishaqhassan.com:2000/category');
    var response =
        await http.get(url, headers: {'Authorization': "Bearer $accessToken"});
    var decodedJson = jsonDecode(response.body);
    List<dynamic> dataArray = decodedJson['data'];
    category = dataArray.map((item) => new Category.fromJson(item)).toList();
    // print('response ============ ${category[0].title}');
  }

  Future GetProducts(accessToken) async {
    var url = Uri.parse('http://ishaqhassan.com:2000/product');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $accessToken"});
    var decodedJson = jsonDecode(response.body);
    List<dynamic> dataList = decodedJson['data'];
    product = dataList.map((item) => Product.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          child: Icon(Icons.shopping_bag_outlined),
          backgroundColor: Color(0xff6CC51D),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 17, right: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFF4F5F9),
              ),
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                children: [
                  Image.asset('lib/assests/images/search.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Color(0xFF868889),
                          fontSize: 15,
                          fontFamily: 'PoppinsMed'),
                      decoration: InputDecoration(
                          hintText: 'Search Keywords',
                          hintStyle: TextStyle(
                              color: Color(0xFF8F8F9E),
                              fontSize: 15,
                              fontFamily: 'PoppinsMed'),
                          border: InputBorder.none),
                    ),
                  ),
                  Image.asset('lib/assests/images/filter.png'),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0xFFF4F5F9),
                  ],
                )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //header
                      Container(
                        margin: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assests/images/homeBanner.png',
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      //banner
                      Container(
                        margin:
                            EdgeInsets.only(left: 18, right: 18, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: "PoppinsSemiBold",
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 23,
                              color: Color(0xFF868889),
                            )
                          ],
                        ),
                      ),
                      //Categories
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 90,
                        child: FutureBuilder(
                            future: GetCategories(
                                authProvider.logInUser!.accessToken),
                            builder: (ctx, snapshot) {
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (ctx, idx) =>
                                      const SizedBox(
                                        width: 10,
                                      ),
                                  itemBuilder: (ctx, idx) => AppCategory(
                                        title: category![idx].title,
                                        image: category![idx].icon,
                                        color: colorFromHex(
                                            (category![idx].color).toString()),
                                        id: category![idx].id,
                                      ),
                                  itemCount: category?.length ?? 0);
                            }),
                      ),
                      //Featured
                      Container(
                        margin: EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Featured Products',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: "PoppinsSemiBold",
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 23,
                              color: Color(0xFF868889),
                            )
                          ],
                        ),
                      ),
                      //Cards
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Expanded(
                          child: FutureBuilder(
                              future: GetProducts(
                                  authProvider.logInUser!.accessToken),
                              builder: (ctx, snapshot) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: product?.length ?? 0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: 180,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 18,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (ctx, idx) => CustomCard(
                                    title: product![idx].title,
                                    id: product![idx].id,
                                    price: product![idx].price,
                                    image: product![idx].image,
                                    color: colorFromHex(product![idx].color!),
                                    unit: product![idx].unit,
                                    qty: product![idx].qty,
                                    catId: product![idx].catId,
                                    stockAvailable: product![idx].stockAvailable,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Color colorFromHex(String color) {
    final hexCode = color.replaceAll("#", "");
    return Color(int.parse("ff$hexCode", radix: 16)).withOpacity(0.2);
  }
}
