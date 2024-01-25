// ignore_for_file: must_be_immutable, file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class SingleOrder extends StatelessWidget{
  SingleOrder({this.imageName=""});
  String imageName="";
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 200,
          padding: EdgeInsets.all(10),
          child: Image(image: NetworkImage(imageName),
          fit: BoxFit.fitHeight,
          width: 200,
          ),
        ),
        ),
    );
  }
}
