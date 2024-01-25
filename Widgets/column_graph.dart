// ignore_for_file: unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:flutter/material.dart';

class ColumnGraph extends StatefulWidget {
  const ColumnGraph({super.key});

  @override
  State<ColumnGraph> createState() => ColumnGraphState();
}

class ColumnGraphState extends State<ColumnGraph> {
final streamChart = FirebaseFirestore.instance.collection('Orders').snapshots(includeMetadataChanges: true);
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Orders');
  void getMessages() async {
    await for (var item in firestore.collection('Orders').snapshots()) {
      for (var order in item.docs) {
        getDataFromFirebase();
      }
    }
  }
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
  int currentMonth = DateTime.now().month;
  int currentMonthOrders = 0;
  int previousMonthOrders = 0;
  int twoMonthsBackOrders = 0;
  int threeMonthsBackOrders = 0;
  
  int ordersCurrentMonth(){
    int orders=0;
    for(int i=0; i<items.length; i++){
      if(currentMonth - items[i]["Month"] == 0){
        orders+=1;
      }
    }
    currentMonthOrders = orders;
  return currentMonthOrders;
  }
  int calculateMonthsDifference(int current, int monthofOrder){
    int monthDifference = 0;
    if(current - monthofOrder < 0){
      monthDifference = current - monthofOrder;
      monthDifference = 12 - monthDifference;
    } else{
      monthDifference = current - monthofOrder;
    }
    return monthDifference;
  }
  void ordersPreviousMonth(){
    int orders=0;
    for(int i=0; i<items.length; i++){
      if(calculateMonthsDifference(currentMonth, items[i]["Month"]) == 1){
        orders+=1;
      }
    }
    previousMonthOrders = orders;
  }
  void orders2MonthsBack(){
    int orders=0;
    for(int i=0; i<items.length; i++){
      if(calculateMonthsDifference(currentMonth, items[i]["Month"]) == 2){
        orders+=1;
      }
    }
    twoMonthsBackOrders = orders;
  }
  void orders3MonthsBack(){
    int orders=0;
    for(int i=0; i<items.length; i++){
      if(calculateMonthsDifference(currentMonth, items[i]["Month"]) == 3){
        orders+=1;
      }
    }
    threeMonthsBackOrders = orders;
  }
  void initstate(){
    super.initState();
    getDataFromFirebase();
    getMessages();
    ordersCurrentMonth();
    orders2MonthsBack();
    orders3MonthsBack();
    ordersPreviousMonth();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
              stream: streamChart, 
              builder: (context, snapshot){
              return AspectRatio(aspectRatio: 16/9,
                child: DChartBarO(
                  groupList: [
                    OrdinalGroup(
                  id: '1',
                  data: [
                    OrdinalData(domain: "This month", measure: currentMonthOrders),
                    OrdinalData(domain: "Previous month", measure: previousMonthOrders),
                    OrdinalData(domain: "2 months old", measure: twoMonthsBackOrders),
                    OrdinalData(domain: "3 months old", measure: threeMonthsBackOrders),
                  ],
                ),
                  ],
                ),
              );
            });
  }
}