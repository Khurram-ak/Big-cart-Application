import 'dart:convert';

import 'package:ecommerce_app/Models/ApiResponse.dart';
import 'package:ecommerce_app/Providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  ApiResponse? apiResponse;

  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  signInApi(BuildContext ctx, AuthProvider authProvider) {
    Future<Map<String, dynamic>> loginResponse =
        authProvider.GetUserSignIn(_emailCtrl.text, _passCtrl.text);
    loginResponse.then((value) => {
          if (value["isLogIn"] == true)
            {
              authProvider.setUser(value['user']),
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login Successfully!"))),
              Future.delayed(Duration(seconds: 1),
                  () => {Navigator.pushNamed(context, '/home')})
            }
        });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: 480,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('lib/assests/images/signIn.png')),
              ),
            ),
            Positioned(
              bottom: 0,

              left: 0,
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 18, right: 18),
                decoration:const BoxDecoration(
                  color: Color(0xFFF4F5F9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                height: 450,
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome back ! ",
                            style: TextStyle(
                                fontSize: 30, fontFamily: "PoppinsSemiBold"),
                          ),
                          const Text(
                            "Sign in to your account",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: "PoppinsMed",
                                color: Color(0xFF868889)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 11),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            padding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Image.asset('lib/assests/images/mailIcon.png'),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _emailCtrl,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: 'PoppinsMed'),
                                    decoration: const InputDecoration(
                                        hintText: 'Email Address',
                                        hintStyle: TextStyle(
                                            color: Color(0xFF8F8F9E),
                                            fontSize: 15,
                                            fontFamily: 'PoppinsMed'),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            padding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Image.asset('lib/assests/images/passIcon.png'),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    controller: _passCtrl,
                                    style: const TextStyle(
                                        color: Color(0xFF868889),
                                        fontSize: 15,
                                        fontFamily: 'PoppinsMed'),
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Password',
                                        hintStyle: TextStyle(
                                            color: Color(0xFF8F8F9E),
                                            fontSize: 15,
                                            fontFamily: 'PoppinsMed'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Image.asset('lib/assests/images/eyeIcon.png'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 18),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset('lib/assests/images/toggler.png'),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Expanded(
                                    child: Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "PoppinsMed",
                                      color: Color(0xFF868889)),
                                )),
                                const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "PoppinsMed",
                                      color: Color(0xFF407EC7)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    signInApi(context, authProvider);
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
                                      "Login",
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
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                    color: Color(0xFF868889),
                                    fontFamily: "PoppinsMed",
                                    fontSize: 15),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/signup");
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "PoppinsMed",
                                        fontSize: 15),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
