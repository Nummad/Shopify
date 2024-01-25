// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/itemScreen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  static const double Radius = 25;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: EdgeInsets.only(top: 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar( 
                  radius: Radius,
                  backgroundColor: globalVariables.lightBlack,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ItemScreen(category: "Laptop");
                      }));
                    },
                    icon: Icon(Icons.laptop, size: 35, color: Colors.white,),),
                ),
                SizedBox(height: 5),
                Text("Laptops", style: globalVariables.categoriesTypeStyle,),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: Radius,
                  backgroundColor: globalVariables.lightBlack,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ItemScreen(category: "Mobiles");
                      }));
                    },
                    icon: Icon(Icons.phone_android, size: 35, color: Colors.white,),),
                ),
                SizedBox(height: 5),
                Text("Mobiles", style: globalVariables.categoriesTypeStyle,),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: Radius,
                  backgroundColor: globalVariables.lightBlack,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ItemScreen(category: "Watches");
                      }));
                    },
                    icon: Icon(Icons.watch, size: 35, color: Colors.white,),),
                ),
                SizedBox(height: 5),
                Text("Watches", style: globalVariables.categoriesTypeStyle,),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: Radius,
                  backgroundColor: globalVariables.lightBlack,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ItemScreen(category: "Head phones");
                      }));
                    },
                    icon: Icon(Icons.headset, size: 35, color: Colors.white,),),
                ),
                SizedBox(height: 5),
                Text("Headsets", style: globalVariables.categoriesTypeStyle,),
              ],
            ),
          ],
        ),
    );
  }
}