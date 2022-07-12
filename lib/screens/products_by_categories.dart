import 'dart:convert';

import 'package:ecommerce_app/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Models/AllProducts.dart';
import '../Models/User.dart';
import '../Providers/AuthProvider.dart';
import 'package:flutter/services.dart';

class ProductsByCategories extends StatefulWidget {
  String? categoryId;
  String? catTitle;
  String? accessToken;
  ProductsByCategories({this.catTitle,this.categoryId, this.accessToken});

  @override
  State<ProductsByCategories> createState() => _CategoriesState();
}

class _CategoriesState extends State<ProductsByCategories> {

  List<Product>? product;
  void initState() {
    // getProductsByCategories();
    super.initState();
  }

   getProductsByCategories()async{
    try{

    var url=Uri.parse("http://ishaqhassan.com:2000/product/${widget.categoryId}");
    var response= await http.get(url, headers: {'Authorization': "Bearer ${widget.accessToken}"});
    var decodedJson=jsonDecode(response.body);
    List<dynamic> dataList=decodedJson['data'];
     product=dataList.map((item) => Product.fromJson(item)).toList();

    }
    catch(e){
      print("ERROR YAHA HAI HEHE $e");
    }

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "${widget.catTitle}",
          style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold'),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assests/images/categoryfilter.png'),
              SizedBox(
                width: 50,
              )
            ],
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Expanded(
            child: FutureBuilder(
              future:getProductsByCategories() ,
              builder:(ctx,snapshot) {
               return GridView.builder(
                shrinkWrap: true,
                itemCount: product?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 180,
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18),
                itemBuilder: (ctx, idx) => CustomCard(
                  id: product?[idx]?.id,
                  title:product?[idx]?.title ,
                  price: product?[idx]?.price,
                  image: product?[idx]?.image,
                  color:colorFromHex(product![idx].color!),
                  unit: product?[idx]?.unit,
                  catId:product?[idx]?.catId,
                  stockAvailable:product?[idx]?.stockAvailable,
                ),
              );}
            ),
          )),
    );
  }
  Color colorFromHex(String color) {
    final hexCode = color.replaceAll("#", "");
    return Color(int.parse("ff$hexCode", radix: 16)).withOpacity(0.2);
  }
}
