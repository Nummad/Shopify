import 'package:ecommerce/screens/analytics_screen.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/products_screen.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/routing/routes.dart' as routes;
import 'package:shared_preferences/shared_preferences.dart';
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final auth = FirebaseAuth.instance;
  int index=0;
  int number = 0;
  double bottomBarWidth = 40;
  double bottonBarBorderWidth = 5;
  List<Widget> pageContent = [
    ProductsScreen(),
    Analytics(),
    OrdersScreen(),
  ];
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Text("Admin"),
              IconButton(onPressed: ()async{
                auth.signOut();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(SplashScreenState.loginKey, true);  
                Navigator.of(context).pushNamedAndRemoveUntil(routes.authScreen, (route) => false);
              }, 
              icon: Icon(Icons.logout_outlined)),
            ],
          ),
          ],
        ),
      ),
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
            // Posts
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
            // Analytics
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
                    color: (index==1) ? Colors.white : Colors.black,
                    width: bottonBarBorderWidth,
                  ))
                ),
                child: Icon(Icons.analytics_outlined),
                        ),
              ),
            label: '',
            ),
            //Orders
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
                child: Icon(Icons.all_inbox_outlined),
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