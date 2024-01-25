import 'package:ecommerce/screens/add_product.dart';
import 'package:ecommerce/screens/admin_screen.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/homeScreen.dart';
import 'package:ecommerce/screens/signin.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:ecommerce/widgets/itemScreen.dart';
import 'routes.dart' as routes;
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case routes.authScreen: 
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
      case routes.signIn:
        return MaterialPageRoute(
          builder: (context) => SignIn(),
        );
      case routes.signUp:
        return MaterialPageRoute(
          builder: (context) => SignUp(),
        );
      case routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case routes.addProduct:
        return MaterialPageRoute(
          builder: (context) => AddProduct(),
        );  
      case routes.adminScreen:
        return MaterialPageRoute(
          builder: (context) => AdminScreen(),
        );  
      case routes.itemScreen:
        return MaterialPageRoute(
          builder: (context) => ItemScreen(category: "",),
        );  
    default: 
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Text("Wrong route"),
        ));
  }
}