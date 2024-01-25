// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/sign-up%20sign-in%20button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/routing/routes.dart' as routes;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Shopify",
              style: globalVariables.shopifyStyle
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: (){
                Navigator.popAndPushNamed(context, routes.signIn);
              },
              child: Buttons(
                text: "Sign in",
                boxColor: globalVariables.darkBlack,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: (){
                Navigator.popAndPushNamed(context, routes.signUp);
              },
              child: Buttons(
                text: "Sign up",
                boxColor: globalVariables.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
