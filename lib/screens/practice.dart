import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('aaa assa dd'),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 25,right: 25),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 18,mainAxisSpacing: 18) ,
                    itemBuilder: (_,idx)=> Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.amber
                      ),
                      child: Center(child: Text("HELLO")),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'lib/assests/images/signIn.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Vegetables",
                style: TextStyle(
                    color: Color(0xFF868889),
                    fontSize: 12,
                    fontFamily: 'PoppinsMed'),
              )
            ],
          ),
* */
