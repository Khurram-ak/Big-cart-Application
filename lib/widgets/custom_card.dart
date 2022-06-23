import 'package:ecommerce_app/Models/AllProducts.dart';
import 'package:ecommerce_app/Providers/CartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  String? title, unit, image;
  double? price;
  Color? color;
  int? id;
  int? stockAvailable;
  int? qty;
  String? type = "";
  int? catId;

  @override
  State<CustomCard> createState() => _CustomCardState();

  CustomCard(
      {this.title,
      this.id,
      this.price,
      this.image,
      this.color,
      this.unit,
      this.stockAvailable,
      this.qty,
      this.type,
      this.catId});
}

class _CustomCardState extends State<CustomCard> {
  bool qtyDisplay = false;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);

    return Container(
        height: 200,
        child: Card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                  ),
                  child: Center(
                      child: Image.network(
                    "${widget.image}",
                    width: 60,
                    height: 60,
                  ))),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${widget.price}',
                style: const TextStyle(
                    color: Color(0xFF6CC51D),
                    fontSize: 12,
                    fontFamily: 'PoppinsMed'),
              ),
              Text(
                "${widget.title}",
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: "PoppinsSemiBold",
                ),
              ),
              Text(
                '${widget.unit}',
                style: const TextStyle(
                    color: Color(0xFF868889),
                    fontSize: 12,
                    fontFamily: 'PoppinsMed'),
              ),
              const Divider(
                thickness: 1,
              ),
              !cartProvider.isProductAdded(Product(id: widget.id))
                  ? GestureDetector(
                      onTap: () {
                        cartProvider.addProduct(Product(
                            id: widget.id,
                            title: widget.title,
                            unit: widget.unit,
                            price: widget.price,
                            qty: 1,
                            image: widget.image,
                            color: (widget.color).toString(),
                            catId: widget.catId,
                            stockAvailable: widget.stockAvailable));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('lib/assests/images/cart.png'),
                          SizedBox(width: 5),
                          const Text(
                            'Add To Cart',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'PoppinsSemiBold'),
                          )
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cartProvider.getQty(Product(id: widget.id));
                              cartProvider.decrement(Product(
                                id: widget.id,
                              ));
                            });
                          },
                          child: Image.asset('lib/assests/images/minus.png'),
                        ),
                        Text(
                          '${cartProvider.getQty(Product(id: widget.id))}',
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'PoppinsSemiBold'),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cartProvider.increment(Product(
                                id: widget.id,
                              ));
                            });
                          },
                          child: Image.asset('lib/assests/images/plus.png'),
                        ),
                      ],
                    )
            ])));
  }

  Color colorFromHex(String color) {
    final hexCode = color.replaceAll("#", "");
    return Color(int.parse("ff$hexCode", radix: 16)).withOpacity(0.2);
  }
}
