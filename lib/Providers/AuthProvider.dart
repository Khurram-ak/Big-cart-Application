import 'dart:convert';
import 'package:ecommerce_app/Models/ApiResponse.dart';
import 'package:ecommerce_app/Models/User.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  User? logInUser;

  Future<Map<String,dynamic>> GetUserSignIn(String userEmail, String userPassword) async {

    var isLogIn =false;

    Map<String, dynamic>? result;
    String? message;
    notifyListeners();

    try {
      var url =await Uri.parse('http://ishaqhassan.com:2000/user/signin');
      var response = await http.post(url, body: {'email': userEmail, 'password': userPassword});
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        var signInApiResponse = ApiResponse.fromJson(decodedJson);
        isLogIn=true;
        message=signInApiResponse.message;
        notifyListeners();

        return result = {
          "isLogIn":isLogIn,
          "message": message,
          "user":signInApiResponse.data,
        };
      }
      else{
        var decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        var signInApiResponse = ApiResponse.fromJson(decodedJson);
        isLogIn=false;
        message=signInApiResponse.message;
        notifyListeners();
        return result={
          "isLogIn":isLogIn,
          "message": message,
        };
      }
    }
    catch (e) {
      print('error hai YAHA $e');
      return result = {"message": e};
    }
  }

  void setUser(userData){
    print("USER INSTANCE ${userData}");

    logInUser=userData;
    notifyListeners();
  }

}
