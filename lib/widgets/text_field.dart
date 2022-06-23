import 'package:flutter/material.dart';

class CheckoutTextField extends StatelessWidget {

  FormFieldSetter onSavedValue;
  String? hintText;
  String? image;
 CheckoutTextField({ required this.onSavedValue,this.hintText,   this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          Image.asset('$image'),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextFormField(
              onSaved: onSavedValue,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 15, fontFamily: 'PoppinsMed'),
              decoration:   InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      color: Color(0xFF8F8F9E),
                      fontSize: 15,
                      fontFamily: 'PoppinsMed'),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
