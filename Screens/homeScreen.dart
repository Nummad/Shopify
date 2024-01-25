// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/widgets/Headset.dart';
import 'package:ecommerce/widgets/Laptops.dart';
import 'package:ecommerce/widgets/Mobiles.dart';
import 'package:ecommerce/widgets/Watches.dart';
import 'package:ecommerce/widgets/top_categories.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/global_variables.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title: Row(
          children: [
            Icon(Icons.shopping_cart_outlined),
            SizedBox(width: 10),
            Text(globalVariables.shoppify),
          // Text("Buyer section"),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 15),
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              "Categories",
              textAlign: TextAlign.left,
              style: globalVariables.categoriesStyle
            ),
          ),
          TopCategories(),
          Laptop(),
          SizedBox(height: 20),
          Mobile(),
          SizedBox(height: 20),
          Watch(),
          SizedBox(height: 20),
          Headsets(),
        ],
      ),
    );
  }
}