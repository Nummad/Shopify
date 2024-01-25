//Individual product category screen, contains product of the same category
// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, file_names, avoid_function_literals_in_foreach_calls, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_adjacent_string_concatenation

import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/screens/order_details.dart';
import 'package:ecommerce/services/buyer_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_auth/firebase_auth.dart';

class ItemScreen extends StatefulWidget {
  String category = "";
  ItemScreen({required this.category});
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Buyer buyer = Buyer();
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
      }
    }
  }
  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    getMessages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.category),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index]["Category"] == widget.category
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return OrderDetails(
                            imageUrl: items[index]["Images"],
                            productDescription: items[index]["Description"],
                            productName: items[index]["Name"],
                            productPrice: items[index]["Price"],
                            productQunatity: items[index]["Quantity"],
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        height: 480,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: globalVariables.lightBlack,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250,
                              color: Colors.white,
                              child: items[index]["Category"] == widget.category
                                  ? Image(
                                      image:
                                          NetworkImage(items[index]["Images"]))
                                  : Container(),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                items[index]["Category"] == widget.category
                                    ? Text(
                                        items[index]["Name"].toString().length >
                                                13
                                            ? "${items[index]["Name"].toString().substring(0, 12)}" +
                                                "..."
                                            : items[index]["Name"].toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                    : Container(),
                                items[index]["Category"] == widget.category
                                    ? Text(
                                        items[index]["Quantity"].toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 150,
                              child: SingleChildScrollView(
                                child: items[index]["Category"] ==
                                        widget.category
                                    ? Text(
                                        items[index]["Description"].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            }),
      ),
    );
  }
}
