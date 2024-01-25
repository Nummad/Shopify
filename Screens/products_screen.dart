// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/routing/routes.dart' as routes;
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_auth/firebase_auth.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Products');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Products');
  final user = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var collection = FirebaseFirestore.instance.collection('Products');
  List<Map<String, dynamic>> items = [];

  void getDataFromFirebase() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();

    data.docs.forEach((element) {
      tempList.add(element.data());
    });

    setState(() {
      items = tempList;
    });
  }

  void getMessages() async {
    await for (var item in firestore.collection('Products').snapshots()) {
      for (var order in item.docs) {
        getDataFromFirebase();
        print(order.data());
        print('Length : ${items.length}');
      }
    }
  }

  void NavigateToAddProduct() {
    Navigator.pushNamed(context, routes.addProduct);
  }

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    getMessages();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Mobile phones",
                 style: globalVariables.categoriesStyle,
              ),
              SizedBox(height: 10),
            Container(
              height: 190,
              width: 100.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return (items[index]["Category"] == "Mobiles")
                        ? singleProduct(
                            name: items[index]['Name'],
                            price: items[index]['Price'],
                            imageUrl: items[index]["Images"],
                            quantity: items[index]["Quantity"],
                          )
                        : Text("");
                  }),
            ),
            SizedBox(height: 20),
              Text(
                "Watches",
                 style: globalVariables.categoriesStyle,
              ),
              SizedBox(height: 10),
            Container(
              height: 190,
              width: 100.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return (items[index]["Category"] == "Watches")
                        ? singleProduct(
                            name: items[index]['Name'],
                            price: items[index]['Price'],
                            imageUrl: items[index]["Images"],
                            quantity: items[index]["Quantity"],
                          )
                        : Text("");
                  }),
            ),
            SizedBox(height: 20),
              Text(
                "Laptops",
                 style: globalVariables.categoriesStyle,
              ),
              SizedBox(height: 10),
            Container(
              height: 190,
              width: 100.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return (items[index]["Category"] == "Laptop")
                        ? singleProduct(
                            name: items[index]['Name'],
                            price: items[index]['Price'],
                            imageUrl: items[index]["Images"],
                            quantity: items[index]["Quantity"],
                          )
                        : Text("");
                  }),
            ),
            SizedBox(height: 20),
              Text(
                "Head phones",
                 style: globalVariables.categoriesStyle,
              ),
              SizedBox(height: 10),
            Container(
              height: 190,
              width: 100.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return (items[index]["Category"] == "Head phones")
                        ? singleProduct(
                            name: items[index]['Name'],
                            price: items[index]['Price'],
                            imageUrl: items[index]["Images"],
                            quantity: items[index]["Quantity"],
                          )
                        : Text("");
                  }),
            ),
            
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a product",
        backgroundColor: globalVariables.darkBlack,
        onPressed: () {
          NavigateToAddProduct();
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
