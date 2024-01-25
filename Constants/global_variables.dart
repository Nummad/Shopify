import 'package:flutter/Material.dart';

class globalVariables{
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const String shoppify = "Shopify";
  static const TextStyle shopifyStyle = TextStyle(
    color: Colors.black,
    fontSize: 40,
  );
  //color of scaffold
  static const backgroundColor = Colors.white; //Color(0xFF0A0E21);
  static const darkBlack = Colors.black;
  static const lightBlack = const Color.fromRGBO(117, 117, 117, 1);
  static const appbarColor = Color(0xFF1D1E33);
  static Color itemsColor= Color(0xFF4C4F5E);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const Color accountScreenButtonColor = Color.fromARGB(255, 172, 170, 170);

  static const Color iconColor = Colors.white;
  static const unselectedNavBarColor = Colors.black87;
  static const darkBlue = Color.fromRGBO(33, 150, 243, 1);
  static const lightBlue = Colors.lightBlue;
  static const TextStyle categoriesStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ); 
  static const TextStyle categoriesTypeStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w500); 
}