import 'package:ecommerce_app/Providers/CartProvider.dart';
import 'package:ecommerce_app/Providers/AuthProvider.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/order.dart';
import 'package:ecommerce_app/screens/products_by_categories.dart';
import 'package:ecommerce_app/screens/checkout.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/practice.dart';
import 'package:ecommerce_app/screens/sign_in.dart';
import 'package:ecommerce_app/screens/sign_up.dart';
import 'package:ecommerce_app/screens/splash.dart';
import 'package:ecommerce_app/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
            title: 'E-commerce App',
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            onGenerateRoute: (RouteSettings settings) {
              Map<String, Widget> pages = {
                "/": Splash(),
                "/signin": SignIn(),
                "/signup": SignUp(),
                "/home": Home(),
                "/categories": ProductsByCategories(),
                "/cart": Cart(),
                "/checkout": Checkout(),
                "/order":OrderConfirmation()
              };
              var pageToShow = pages[settings.name] ?? Splash();
              if (settings.name == "/") {
                pageToShow = Splash();
              } else if (settings.name == "/signin") {
                pageToShow = SignIn();
              } else if (settings.name == "/home") {
                pageToShow = Home();
              } else if (settings.name == "/categories") {
                if (settings.arguments != Null &&
                    settings.arguments is Map<String, String>) {
                  pageToShow = ProductsByCategories(
                      catTitle:(settings.arguments as Map<String,String>)['title'],
                      categoryId: (settings.arguments as Map<String,
                          String>)['categoryId'],
                    accessToken: (settings.arguments as Map<String,
                        String>)['accessToken'],
                  );
                }
              } else if (settings.name == "/cart") {
                pageToShow = Cart();
              } else if (settings.name == "/checkout") {
                pageToShow = Checkout();
              } else if (settings.name == "/signup") {
                pageToShow = SignUp();
              }else if (settings.name == "/order") {
                pageToShow = OrderConfirmation();
              }

              return MaterialPageRoute<String>(
                  builder: (childContext) => pageToShow, settings: settings);
            },
            // home: Practice()
            home: Splash()));
  }
}
