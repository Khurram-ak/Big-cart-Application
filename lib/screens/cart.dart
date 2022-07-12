import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../Models/AllProducts.dart';
import '../Providers/CartProvider.dart';
import '../widgets/cart_items.dart';
import 'package:flutter/services.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    var shippingCharges = 1.6;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Shopping Cart",
            style:
                TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold'),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(color: Color(0xFFF4F5F9)),
                    child: ListView.separated(
                        itemCount: cartProvider.productsList.length,
                        itemBuilder: (ctx, idx) {
                          Product product = cartProvider.productsList[idx];
                          return Slidable(
                              key: ValueKey(idx),
                              endActionPane: ActionPane(
                                dismissible: DismissiblePane(
                                  onDismissed: () {
                                    cartProvider.removeProduct(product.id!);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                            leading: Container(
                                                height: 64,
                                                width: 64,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0x33ffc0a)),
                                                child: Center(
                                                    child: Image.network(
                                                  "${product.image}",
                                                  width: 50,
                                                  height: 50,
                                                ))),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '\$${product.price} x ${product.qty}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF6CC51D),
                                                      fontSize: 12,
                                                      fontFamily: 'PoppinsMed'),
                                                ),
                                                Text(
                                                  "${product.title}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                  ),
                                                ),
                                                Text(
                                                  '${product.unit}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF868889),
                                                      fontSize: 12,
                                                      fontFamily: 'PoppinsMed'),
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      cartProvider
                                                          .increment(Product(
                                                        id: product.id,
                                                      ));
                                                    });
                                                  },
                                                  child: Image.asset(
                                                      'lib/assests/images/plus.png'),
                                                ),
                                                Text(
                                                  '${cartProvider.getQty(Product(id: product.id))}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'PoppinsSemiBold'),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      cartProvider.getQty(
                                                          Product(
                                                              id: product.id));
                                                      cartProvider
                                                          .decrement(Product(
                                                        id: product.id,
                                                      ));
                                                    });
                                                  },
                                                  child: Image.asset(
                                                      'lib/assests/images/minus.png'),
                                                ),
                                              ],
                                            )),
                                      ])));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 11);
                        }))),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 234,
                    child: Container(
                      margin: EdgeInsets.only(left: 17, right: 17, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(
                                    color: Color(0xFF868889),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsMed'),
                              ),
                              Text(
                                '\$${cartProvider.getTotalPrice()}',
                                style: const TextStyle(
                                    color: Color(0xFF868889),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsMed'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Shipping Charges',
                                style: TextStyle(
                                    color: Color(0xFF868889),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsMed'),
                              ),
                              Text(
                                '\$${shippingCharges}',
                                style: const TextStyle(
                                    color: Color(0xFF868889),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsMed'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "PoppinsSemiBold",
                                ),
                              ),
                              Text(
                                "\$${cartProvider.getTotalPrice() + shippingCharges}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "PoppinsSemiBold",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/checkout');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color(0xFFAEDC81),
                                          Color(0xFF6CC51D),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Checkout",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontFamily: 'PoppinsSemiBold'),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  int colorFromHex(String color) {
    return (int.parse("$color"));
  }
}
