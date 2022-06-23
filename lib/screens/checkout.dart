import 'package:ecommerce_app/Models/OrderModel.dart';
import 'package:ecommerce_app/Providers/AuthProvider.dart';
import 'package:ecommerce_app/Providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../Models/AllProducts.dart';
import '../widgets/text_field.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final checkoutForm = GlobalKey<FormState>();
  String? _name, _email, _phone, _address, _city, _country, _zipcode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF4F5F9)),
        margin: EdgeInsets.only(left: 13, right: 13),
        child: Form(
          key: checkoutForm,
          child: Column(
            children: [
              SizedBox(height: 15),
              CheckoutTextField(
                  onSavedValue: (value) => _name = value,
                  hintText: "Name",
                  image: "lib/assests/images/person_icon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _email = (value),
                  hintText: "Email",
                  image: "lib/assests/images/mailIcon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _phone = (value),
                  hintText: "Phone",
                  image: "lib/assests/images/telephone_icon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _address = (value),
                  hintText: "Address",
                  image: "lib/assests/images/location_icon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _zipcode = (value),
                  hintText: "Zipcode",
                  image: "lib/assests/images/zipcode_icon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _city = (value),
                  hintText: "City",
                  image: "lib/assests/images/map_icon.png"),
              CheckoutTextField(
                  onSavedValue: (value) => _country = (value),
                  hintText: "Country",
                  image: "lib/assests/images/world_icon.png"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  onNextPress(context);
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
                  child: const Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'PoppinsSemiBold'),
                  )),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onNextPress(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    final form = checkoutForm.currentState;
    form!.save();

    List<Items> cartItems = [];
    print(cartProvider.productsList);
    for (var e in cartProvider.productsList) {
      cartItems.add(Items(
          id: e.id,
          catId: e.catId,
          title: e.title,
          unit: e.unit,
          stockAvailable: e.stockAvailable,
          image: e.image,
          color: e.color,
          price: e.price,
          qty: e.qty));
    }
    // cartProvider.productsList.map((e) =>);

    OrderModel orderModel = OrderModel(
        name: _name,
        email: _email,
        phoneNumber: _phone,
        address: _address,
        zip: _zipcode,
        city: _city,
        country: _country,
        items: cartItems);

    final Future<Map<String, dynamic>> orderResponse = cartProvider.placeOrder(
        authProvider.logInUser!.accessToken!, orderModel);

    orderResponse.then((value) => {
      if (value["order"]==true) {
      Navigator.pushNamed(context, "/order")
    }});
  }
}
