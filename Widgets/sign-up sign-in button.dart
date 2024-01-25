// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Buttons extends StatelessWidget {
  Buttons({
    this.text, this.boxColor,
  });
  String? text;
  Color? boxColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}