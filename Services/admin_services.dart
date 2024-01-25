// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin {
  final user = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void sellProduct({
    required BuildContext context,
    required String productname,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("drqsg1eyh", "uz56fy4u");
      List<String> imageUrls = [];
      for(int i=0; i<images.length; i++){
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: category),
        );
        imageUrls.add(res.secureUrl);
      }  
      imageUrls.remove('[');
      imageUrls.remove(']');
      firestore.collection('Products').add({
                  'Name': productname,
                  'Category': category,
                  'Description': description,
                  'Price': price,
                  'Quantity': quantity,
                  'Images': imageUrls[0],
                });
      showSnackBar(context, "Product added");   
      Timer(Duration(seconds: 2), () { 
        Navigator.pop(context);
      });       
    } catch (e) {
      print(e);
    }
  }
}
