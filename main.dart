// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/routing/router.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_core/firebase_core.dart'; //firebase packages
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return FlutterSizer(
      builder:(context, orientation , screenType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: globalVariables.itemsColor,
          ),
          iconTheme: IconThemeData(
            color: globalVariables.iconColor,
          ),
          scaffoldBackgroundColor: globalVariables.backgroundColor,    
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: globalVariables.darkBlack,
            elevation: 5,
          ),
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: SplashScreen(),
        // home: AdminScreen(),
      );
      }
    );
  }
}