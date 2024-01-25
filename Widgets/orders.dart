// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/singleOrder.dart';
import 'package:flutter/material.dart';

class orders extends StatefulWidget {
    List<Map<String, dynamic>> items = [];
    String category;
  orders({required this.items, this.category=""});

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
      color: globalVariables.accountScreenButtonColor,
      borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index){
          return widget.items[index]["Category"] == widget.category ? SingleOrder(
            imageName: widget.items[index]["Images"]) : Text("");
      })
    );
  }
}