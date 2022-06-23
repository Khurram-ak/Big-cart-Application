import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/CartProvider.dart';
import 'package:flutter/services.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height / 2 - 200),
              Image.asset("lib/assests/images/order.png"),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.045),
              const Text("Congrats!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff282828),
                      fontSize: 24)),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
              Consumer<CartProvider>(
                builder: (ctx, provider, child) {
                  return Text(
                    "Your Order #${provider.orderResponse!.orderId} is \n Successfully Received",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB1B1B1),
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 17, right: 17, bottom: 36),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context,listen: false).productsList=[];
                      Navigator.pushNamed(context, "/home");
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
                            "Home",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'PoppinsSemiBold'),
                          )),
                    ),
                  ))
            ]));
  }
}
// Consumer<CartProvider>(
// builder: (ctx,provider,child){
// return Center(0xFFF4F5F9
// child:Text("YOUR ORDER ID IS ${provider.orderResponse?.orderId}",style: TextStyle(fontFamily: "PoppinsMed",fontSize: 25),),
// );
// },
// )
