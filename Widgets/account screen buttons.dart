// ignore_for_file: camel_case_types, must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class accountScreenButton extends StatelessWidget {
  accountScreenButton({
    this.buttonColor=Colors.white,
    this.buttonText="",
  });
  Color buttonColor;
  String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 40.w,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: OutlinedButton(
        onPressed: (){},
        child: Center(
          child: Text(buttonText,
          style: TextStyle(
            fontSize: 15,
          ),
          ),
        ),
      ),
    );
  }
}