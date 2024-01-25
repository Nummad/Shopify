//Shows all the orders to the admin
import 'package:ecommerce/constants/global_variables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OrdersScreen extends StatefulWidget {

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Orders');
  void getMessages() async {
    await for (var item in firestore.collection('Orders').snapshots()) {
      for (var order in item.docs) {
        getDataFromFirebase();
        print(order.data());
        print('Length : ${items.length}');
      }
    }
  }

  final user = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var collection = FirebaseFirestore.instance.collection('Orders');
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
    print("del fun, value is $name");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('Name', isEqualTo: '$name')
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.update({'Flag': true});
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
    );
  }
  int getIndex(){
    int index=0;
    for(int i=0; i<items.length; i++){
      if(items[i]["Flag"]==false){
        index+=1;
      }
    }
    return index;
  }
  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    getMessages();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: items.length==0 || getIndex()==0 ? 
      Center(
        child: Text(
          "No orders yet :)",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ) :
      Container(
        child: ListView.builder(
            itemCount: getIndex(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: 570,
                width: double.infinity,
                decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        showAlert(context, items[index]["Name"]);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.white,
                        child: items[index]["Flag"] == false ? 
                            Image(image: NetworkImage(items[index]["Images"]))
                            : Container(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 30,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: items[index]["Flag"] == false ?  
                        Text(
                          items[index]["Name"].toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ) : Container(),
                      ),
                    ),
                    SizedBox(height: 20),
                    items[index]["Flag"] == false ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text(
                          items[index]["Quantity"].toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    items[index]["Flag"] == false ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bill", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text(
                          items[index]["Price"].toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    items[index]["Flag"] == false ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Buyer", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text(
                          items[index]["Buyer name"].toString().length > 14 ? 
                          items[index]["Buyer name"].toString().substring(0,13) + " .." :
                          items[index]["Buyer name"],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    items[index]["Flag"] == false ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text(
                          items[index]["Phone number"].toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    items[index]["Flag"] == false ? 
                    Container(
                      height: 60,
                      child: SingleChildScrollView(
                        child: Text(
                          items[index]["Address"].toString(),
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
