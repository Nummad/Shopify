import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/account%20screen%20buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AccountScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
          children: [
            Icon(Icons.shopping_cart_outlined),
            SizedBox(width: 2.w),
            Text(globalVariables.shoppify),
          ],
        ),
          Icon(Icons.notifications),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              accountScreenButton(
                buttonColor: globalVariables.accountScreenButtonColor,
                buttonText: "Your orders",
              ),
              accountScreenButton(
                buttonColor: globalVariables.accountScreenButtonColor,
                buttonText: "Turn seller",
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              accountScreenButton(
                buttonColor: globalVariables.accountScreenButtonColor,
                buttonText: "Logout",
              ),
              accountScreenButton(
                buttonColor: globalVariables.accountScreenButtonColor,
                buttonText: "To wishlist",
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text("Your orders",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text("See all",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
