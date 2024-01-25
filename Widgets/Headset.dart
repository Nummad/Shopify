//File at homepage to show item images only in horizontal list
import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/widgets/orders.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_auth/firebase_auth.dart';

class Headsets extends StatefulWidget{
  @override
  State<Headsets> createState() => _HeadsetsState();
}

class _HeadsetsState extends State<Headsets> {
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
  @override
  void initState(){
    super.initState();
    getDataFromFirebase();
    getMessages();
  }
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Head sets", style: globalVariables.categoriesStyle,),
        ),
        SizedBox(height: 20),
        orders(items: items, category: "Head phones",),
      ],
    );
  }
}