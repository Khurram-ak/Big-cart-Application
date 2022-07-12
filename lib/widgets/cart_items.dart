import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Models/AllProducts.dart';

class CartItems extends StatefulWidget {

  List<Product>? product;

  CartItems( Product product);

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {

  // void initState(){
  //    print(widget.product);
  //
  // }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return  Slidable(
            key: ValueKey(1),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(
                onDismissed: () {

                },
              ),
              motion: ScrollMotion(),
              extentRatio: 0.150,
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Container(
              height: 100,
              margin: EdgeInsets.only(left: 17, right: 17),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                      leading: Container(
                          height: 64,
                          width: 64,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD2FFD0),
                          ),
                          child: Center(
                              child: Image.asset(
                            "lib/assests/images/vegPic.png",
                            width: 50,
                            height: 50,
                          ))),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\$22.2x4',
                            style: TextStyle(
                                color: Color(0xFF6CC51D),
                                fontSize: 12,
                                fontFamily: 'PoppinsMed'),
                          ),
                          Text(
                            "Avacoda",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "PoppinsSemiBold",
                            ),
                          ),
                          Text(
                            'dozen',
                            style: TextStyle(
                                color: Color(0xFF868889),
                                fontSize: 12,
                                fontFamily: 'PoppinsMed'),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity = quantity + 1;
                                print(quantity);
                              });
                            },
                            child: Image.asset('lib/assests/images/plus.png'),
                          ),
                          Text(
                            '${quantity}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'PoppinsSemiBold',
                                color: Color(0xFF868889)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity != 0
                                    ? quantity = quantity - 1
                                    : quantity = 0;
                                print(quantity);
                              });
                            },
                            child: Image.asset('lib/assests/images/minus.png'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );



  }
}
