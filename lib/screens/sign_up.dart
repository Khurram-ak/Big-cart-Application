import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        child:Stack(
          children: <Widget>[
            Container(
              height: 470,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('lib/assests/images/signUp.png')),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                 padding:EdgeInsets.only(top: 15,left:18,right:18),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F9),
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                ),
                height: 480,
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
                            "Create account ",
                            style: TextStyle(
                                fontSize: 30, fontFamily: "PoppinsSemiBold"),
                          ),
                          const Text(
                            "Quickly create account",
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
                                const Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: 'PoppinsMed'),
                                    decoration: InputDecoration(
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
                                Image.asset('lib/assests/images/telephone_icon.png'),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: 'PoppinsMed'),
                                    decoration: InputDecoration(
                                        hintText: 'Phone number',
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
                                const Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Color(0xFF868889),
                                        fontSize: 15,
                                        fontFamily: 'PoppinsMed'),
                                    decoration: InputDecoration(
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
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient:const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Color(0xFFAEDC81),
                                        Color(0xFF6CC51D),
                                      ],
                                    ),
                                  ),
                                  child: Center(child: Text("Signup",style: TextStyle(fontSize:15,color: Colors.white,fontFamily: 'PoppinsSemiBold' ),)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account ?",style: TextStyle(color:Color(0xFF868889),fontFamily: "PoppinsMed",fontSize: 15),),
                              GestureDetector(
                                  onTap:(){Navigator.pushNamed(context, "/signin");},

                                  child: Text("Login",style: TextStyle(color:Colors.black,fontFamily: "PoppinsMed",fontSize: 15),)),

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