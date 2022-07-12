import 'package:ecommerce_app/Models/OrderModel.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/AllProducts.dart';

class CartProvider extends ChangeNotifier {
  List<Product> productsList = [];

 late OrderModel? orderResponse;
  Future<Map<String,dynamic>> placeOrder(String token,OrderModel  orderModel)async {
    late Map<String, dynamic>? result;
    Map<String, String> _tokendata = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var url = Uri.parse('http://ishaqhassan.com:2000/order');
    // print(jsonEncode(orderModel.toJson()));
    var response =
    await http.post(
        url, headers: _tokendata, body: jsonEncode(orderModel.toJson()));
    var decodedJson = jsonDecode(response.body);
      orderResponse = OrderModel.fromJson(decodedJson["data"]);
    if (decodedJson["statusCode"] == 200) {
      result =
      {"order":true,
        "message": "Order Placed Successfully",
        "orderResponse": orderResponse
      };
      notifyListeners();

    }
    else {
        result =
        {"order":false,
          "messagesss": decodedJson["message"]};
        notifyListeners();

    }
    return result;
    }


  void addProduct(Product product) {
    int Index = getIndex(product.id);
    if (Index == -1) {
      productsList.add(product);
      notifyListeners();
    } else {
      productsList[Index].qty = productsList[Index].qty! + 1;
      notifyListeners();
    }
    print("PRODUCTQTYY+=====${productsList[Index].qty}");
  }

  int getIndex(id) {
    var index = productsList.indexWhere((element) => element.id == id);
    return index;
  }

  int getQty(Product p) {
    var index = getIndex(p.id);
    return productsList[index].qty!;
  }

  void increment(Product p) {
    int Index = getIndex(p.id);
    if (Index != -1) {
      productsList[Index].qty = productsList[Index].qty! + 1;
      String? color = productsList[Index].color;

      notifyListeners();
    }
    getTotalPrice();
    notifyListeners();
  }

  void decrement(Product p) {
    print('decremtn func');
    int Index = getIndex(p.id);
    if (Index != -1) {
      productsList[Index].qty = productsList[Index].qty! - 1;
      if (productsList[Index].qty! <= 0) {
        productsList[Index].qty = 0;
      }
      notifyListeners();
    }
    getTotalPrice();
    notifyListeners();
  }

  bool isProductAdded(Product p) {
    int index = getIndex(p.id);
    if (index == -1) {
      return false;
    }
    return true;
  }

  notifyListeners();


  void removeProduct(int id)
  {
    if(id != null) {
      int index = getIndex(id);
      if (index >= 0) {
        if (productsList[index].id == id) {
          productsList.removeAt(index);
          notifyListeners();
        }
      }
    }
  }

  double getTotalPrice() {
    double totalSum = 0.0;
    double inDouble=0.0;
    String? inString;
    for(var item in productsList) {
      totalSum += item.price! * item.qty!;
      print("totalSum=======${totalSum}");
        inString = totalSum.toStringAsFixed(2);
       inDouble = double.parse(inString);
    }
    return
      inDouble;

  }


}
