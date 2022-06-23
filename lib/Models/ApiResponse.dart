

import 'package:ecommerce_app/Models/User.dart';

class ApiResponse {
  String? message;
  int? statusCode;
  User? data;

  ApiResponse({this.message, this.statusCode, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];

    data=User.fromJson(json["data"] as Map<String,dynamic>);


  }

}

