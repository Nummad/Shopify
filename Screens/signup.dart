// ignore_for_file: use_key_in_widget_constructors, override_on_non_overriding_member, prefer_const_constructors, use_build_context_synchronously

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/customTextField.dart';
import 'package:ecommerce/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/widgets/sign-up%20sign-in%20button.dart';
import 'package:ecommerce/routing/routes.dart' as routes;
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            color: globalVariables.lightBlack,
            controller: emailController,
            text: "Enter email",
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextField(
            color: globalVariables.lightBlack,
            controller: passwordController,
            text: "Enter password",
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextField(
            color: globalVariables.lightBlack,
            controller: confirmPasswordController,
            text: "Enter password again",
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () async {
              if (!(emailController.text.endsWith("@gmail.com"))) {
                showSnackBar(context, "Invalid email");
              } else if(passwordController.text == "" || confirmPasswordController.text == ""){
                showSnackBar(context, "Check your password");
              } else if (passwordController.text !=
                  confirmPasswordController.text) {
                showSnackBar(context, "Passwords doesn't match");
              } else {
                try {
                  await auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                    Navigator.popAndPushNamed(context, routes.signIn);
                } on FirebaseAuthException catch (e) {
                  showSnackBar(context, e.message!);
                }
              }
            },
            child: Buttons(
              text: "Sign up",
              boxColor: globalVariables.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
}
