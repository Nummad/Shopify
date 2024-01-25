// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings, file_names, camel_case_types, unused_local_variable, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
class singleProduct extends StatefulWidget {
  singleProduct({
    this.name = "",
    this.price = 0,
    this.imageUrl = "",
    this.quantity=0,
  });
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;

  @override
  State<singleProduct> createState() => _singleProductState();
}

class _singleProductState extends State<singleProduct> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Products');

  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Products');

  void getMessages() async {
    await for (var item in firestore.collection('Products').snapshots()) {
      for (var order in item.docs) {
        getDataFromFirebase();
      }
    }
  }

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

 void deleteDocument(String name) async {
    if (items.length == 1) {
      setState(() {
        items = [];
      });
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('Name', isEqualTo: '$name')
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
    getMessages();
  }

  void showAlert(BuildContext context, String name) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Deleting!!!',
      text: 'Are you sure you want to delete this?',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.green),
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.red),
      onConfirmBtnTap: (){
        deleteDocument(name);
        Navigator.pop(context);
      },
      // autoCloseDuration: Duration(seconds: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        showAlert(context, widget.name);
      },   //delete a product
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        width: 300,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                widget.imageUrl.startsWith("[")
                    ? widget.imageUrl.replaceAll("[" , "")
                    : widget.imageUrl.endsWith("]")
                        ? widget.imageUrl.replaceAll(']', "")
                        : widget.imageUrl,
              ),
              width: 150,
              // height: 150,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.name.length>9 ? widget.name.substring(0,8)+"..." : widget.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${widget.price}\$",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Items: ${widget.quantity}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
