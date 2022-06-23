import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    super.initState();
    _navigateToApp();

  }

    _navigateToApp()async{
  await Future.delayed(Duration(seconds: 5));
  setState(() {
  Navigator.pushNamed(context, '/signin');

  });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('lib/assests/images/splash.png')),
        ),
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.only(top: 96, bottom: 30),
                  child: Column(
                    children: [
                      const Text(
                        "Welcome to",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: "PoppinsBold"),
                      ),
                      Image.asset('lib/assests/images/logo.png'),
                      Column(
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consetetur",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: "PoppinsMed",
                                color: Colors.grey),
                          ),
                          Text(" sadipscing elitr, sed diam nonumy ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "PoppinsMed",
                                  color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      const Text(
                        'P O W E R E D   B Y',
                        style:
                            TextStyle(color: Colors.grey, fontFamily: "PoppinsMed"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('T E C H   I D A R A',style: TextStyle(color: Color(0xFF6CC51D),fontWeight: FontWeight.w800, fontFamily: 'PoppinsSemiBold',fontSize: 25),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // child: ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/home');},child: Text("HOME"),),
      ),
    );
  }
}
