// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:ecommerce/screens/splash_screen.dart';
import 'package:ecommerce/widgets/customTextField.dart';
import 'package:ecommerce/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/sign-up%20sign-in%20button.dart';
import 'package:ecommerce/routing/routes.dart' as routes;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget{
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();  
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              size: 40,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Shopify",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              controller: emailController,
              text: "Enter email",
            ),
            SizedBox(
              height: 30,
            ),
              CustomTextField(
                controller: passwordController,
                text: "Enter password",
              ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () async {
              if (!(emailController.text.endsWith("@gmail.com"))) {
                showSnackBar(context, "Invalid email");
              } else if(passwordController.text == ""){
                showSnackBar(context, "Check your password");
              } else {
                try {
                  await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(SplashScreenState.loginKey, true);  
                    if(emailController.text == "admin@gmail.com"){
                      Navigator.popAndPushNamed(context, routes.adminScreen);
                    } 
                    else{ 
                      Navigator.popAndPushNamed(context, routes.homeScreen);
                    }
                } on FirebaseAuthException catch (e) {
                  if(e.message == "The supplied auth credential is incorrect, malformed or has expired."){
                    showSnackBar(context, "Check your email/password and try again");
                  } else
                    showSnackBar(context, e.message!);
                }
              }
            },
              child: Buttons(
                text: "Sign in",
                boxColor: globalVariables.darkBlack,
              ),
            ),  
          ],
        ),
    );
  }
// bool getToken(bool logToken){
//   return logToken;
// }
}
