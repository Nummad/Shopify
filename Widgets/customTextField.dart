// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/constants/global_variables.dart';

class CustomTextField extends StatefulWidget{
  TextEditingController? controller;
  TextInputType keyboardType;
  Color color;
  String text;
  CustomTextField({
    required this.controller,
    this.color=globalVariables.darkBlack,
    this.text="",
    this.keyboardType=TextInputType.emailAddress,
  });

  @override
  
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  IconData iconName = Icons.visibility;

  bool obsecureText = true;
  Color iconColor = Colors.grey;
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: 
      TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: (widget.text == "Enter password" || widget.text == "Enter password again") ?
        obsecureText : false,
        controller: widget.controller,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration( 
          suffixIcon: (widget.text == "Enter password" || widget.text == "Enter password again") ?
          IconButton(
            icon: Icon(iconName,
            color: iconColor,),
            onPressed: (){
              setState(() {
                if(obsecureText){
                iconName = Icons.visibility_off;
                iconColor= Colors.grey[800]!;
                obsecureText = false;
              }
              else{
                iconName = Icons.visibility;
                iconColor = Colors.grey;
                obsecureText = true;
              }
              });  
            },
            ) : Icon(Icons.visibility,
            color: globalVariables.backgroundColor,),
          hintText: widget.text,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: widget.color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              width: 2,
              color: widget.color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: widget.color,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}                                                         