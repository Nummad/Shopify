// ignore_for_file: file_names, prefer_const_constructors

import 'package:ecommerce/constants/global_variables.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: globalVariables.backgroundColor,
      content: Container(
        padding: EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
          color: globalVariables.darkBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight:FontWeight.bold,
        ),
        )))),
  );
}
