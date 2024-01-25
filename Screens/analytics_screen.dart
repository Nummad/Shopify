// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:ecommerce/constants/global_variables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class Analytics extends StatefulWidget {
  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final streamChart = FirebaseFirestore.instance
      .collection('Orders')
      .snapshots(includeMetadataChanges: true);
  int currentMonth = DateTime.now().month;

  int ordersThisMonth() {
    DateTime currentDate = DateTime.now();
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (currentDate.month - items[i]["Month"] == 0) {
        orders += 1;
      }
    }
    return orders;
  }

  int calculateMonthsDifference(int current, int monthofOrder) {
    int monthDifference = 0;
    if (current - monthofOrder < 0) {
      monthDifference = current - monthofOrder;
      monthDifference = 12 + monthDifference;
    } else {
      monthDifference = current - monthofOrder;
    }
    return monthDifference;
  }

  int ordersPreviousMonth() {
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (calculateMonthsDifference(currentMonth, items[i]["Month"]) == 1) {
        orders += 1;
      }
    }
    return orders;
  }

  int orders2MonthsBack() {
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (calculateMonthsDifference(currentMonth, items[i]["Month"]) == 2) {
        orders += 1;
      }
    }
    return orders;
  }

  int orders3MonthsBack() {
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (calculateMonthsDifference(currentMonth, items[i]["Month"]) == 3) {
        orders += 1;
      }
    }
    return orders;
  }

  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');

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

  int pendingOrders() {
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i]["Flag"] == false) {
        orders += 1;
      }
    }
    return orders;
  }

  int ordersThisWeek() {
    DateTime currentDate = DateTime.now();
    int orders = 0;
    for (int i = 0; i < items.length; i++) {
      if (currentDate.day - items[i]["Day"] <= 7 && ordersThisMonth() > 0) {
        if (orders < ordersThisMonth()) {
          orders += 1;
        }
      }
    }
    return orders;
  }

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    getMessages();
    ordersThisMonth();
    ordersPreviousMonth();
    orders2MonthsBack();
    orders3MonthsBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total orders",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    items.length.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Orders pending",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    pendingOrders().toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Orders this week",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    ordersThisWeek().toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Orders this month",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    ordersThisMonth().toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: streamChart,
                builder: (context, snapshot) {
                  return AspectRatio(
                    aspectRatio: 13 / 9,
                    child: DChartBarO(
                      fillColor: (group, ordinalData, index) => Colors.green,
                      animate: true,
                      groupList: [
                        OrdinalGroup(
                          id: '1',
                          data: [
                            OrdinalData(
                                domain: "3 months old",
                                measure: orders3MonthsBack()),
                            OrdinalData(
                                domain: "2 months old",
                                measure: orders2MonthsBack()),
                            OrdinalData(
                                domain: "Previous month",
                                measure: ordersPreviousMonth()),
                            OrdinalData(
                                domain: "This month",
                                measure: ordersThisMonth()),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
