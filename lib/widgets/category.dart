import 'package:ecommerce_app/Providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products_by_categories.dart';

class AppCategory extends StatefulWidget {
  String? title;
  String? image;
  Color? color;
  int? id;

  @override
  State<AppCategory> createState() => _CustomCardState();

  AppCategory({this.title, this.image, this.color, this.id});
}

class _CustomCardState extends State<AppCategory> {
  ProductsByCategories? categories;

  @override
  Widget build(BuildContext context) =>   GestureDetector(
        onTap: () async{
          Navigator.pushNamed(context, '/categories',arguments: {
            "title":"${widget.title}",
            "categoryId":"${widget.id}",
            "accessToken": "${
              Provider.of<AuthProvider>(context,listen: false).logInUser?.accessToken
            }"
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color,
                    ),
                    child: Center(
                        child: Image.network(
                      "${widget.image}",
                      width: 29,
                      height: 29,
                    ))
          )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              // "hello",
              "${widget.title}",
              style: const TextStyle(
                  color: Color(0xFF868889),
                  fontSize: 11,
                  fontFamily: 'PoppinsMed'),
            )
          ],
        ),
      );
}
