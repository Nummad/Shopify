// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:ecommerce/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/routing/routes.dart' as routes;

class Buyer {
  final user = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  DateTime today = DateTime.now(); 

  void buyProduct({
    required BuildContext context,
    required String productname,
    required String description,
    required int price,
    required int quantity,
    required String images,
    required String buyerName,
    required String buyerAddress,
    required String buyerPhone,
  }) async {
    try {
      firestore.collection('Orders').add({
                  'Flag': false,
                  'Date': today.day,
                  'Month': today.month,
                  'Name': productname,
                  'Description': description,
                  'Price': price,
                  'Quantity': quantity,
                  'Images': images,
                  'Phone number' :buyerPhone,
                  'Address': buyerAddress,
                  'Buyer name': buyerName,
                });
      showSnackBar(context, "Order placed");   
      Timer(Duration(seconds: 2), () { 
        Navigator.of(context).pushNamedAndRemoveUntil(routes.homeScreen, (routes)=>false);
      });       
    } catch (e) {
      print(e);
    }
  }
}
