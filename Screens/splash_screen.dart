import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/routing/routes.dart' as routes;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String loginKey = "isLoggedIn";
  @override
  void initState(){
    super.initState();
    nextScreen();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              globalVariables.shoppify,
              style: globalVariables.shopifyStyle,
            ),
          ],
        ),
      )
    );
  }
void nextScreen()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool(loginKey);
      if(isLoggedIn!=null && isLoggedIn==true)
    Timer(Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, routes.homeScreen);
     });
      else
    Timer(Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, routes.authScreen);
     });  
}
}
