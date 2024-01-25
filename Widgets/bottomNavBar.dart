// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/screens/accountScreen.dart';
import 'package:ecommerce/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index=0;
  int number = 0;
  double bottomBarWidth = 40;
  double bottonBarBorderWidth = 5;
  List<Widget> pageContent = [
    HomeScreen(),
    AccountScreen(),
    Center(child: Text("Cart"),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageContent[index],
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: globalVariables.darkBlack,
          currentIndex: index,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade600,
          selectedIconTheme: IconThemeData(color: Colors.white, size: 20),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade600, size: 20),
          items: [
            BottomNavigationBarItem(icon: GestureDetector(
              onTap: (){
                setState(() {
                  index=0;
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 5),
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(
                    color: (index==0) ? Colors.white :Colors.black,
                    width: bottonBarBorderWidth,
                  ))
                ),
                child: Icon(Icons.home_outlined),
              ),
            ),
            label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){
                  setState(() {
                    index=1;
                  });
                },
                child: Container(
                padding: EdgeInsets.only(top: 5),
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(
                    color: (index==1) ? Colors.white: Colors.black,
                    width: bottonBarBorderWidth,
                  ))
                ),
                child: Icon(Icons.person_outline_outlined),
                        ),
              ),
            label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){
                  setState(() {
                    index=2;
                  });
                },
                child: Container(
                padding: EdgeInsets.only(top: 5),
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(
                    color: (index==2) ? Colors.white :Colors.black,
                    width: bottonBarBorderWidth,
                  ))
                ),
                child: Center(
                  child: Badge(
                    largeSize: 19, 
                    label: Text(number.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    ),
                    offset: Offset(4,-10),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          number+=1;
                        });
                      },
                      child: Icon(Icons.shopping_cart_outlined)),
                    ),
                ),
                        ),
              ),
            label: '',
            ),
          ],
        ),
      ),
    );
  }
}