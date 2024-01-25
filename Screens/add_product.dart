// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/services/admin_services.dart';
import 'package:ecommerce/utilities/imagePicker.dart';
import 'package:ecommerce/widgets/sign-up%20sign-in%20button.dart';
import 'package:ecommerce/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ecommerce/constants/global_variables.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Admin admin = Admin();
  List<File> images=[];
  List<String> productCategories = [
    "Mobiles",
    "Laptop",
    "Watches",
    "Head phones",
  ];
  String category = "Mobiles";
  TextEditingController nameController = TextEditingController();
  String? text;
  int? maxLines;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add product"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            images.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: Image.file(
                          images[0],
                          fit: BoxFit.fitWidth,
                          width: 200,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(30),
                      dashPattern: [10, 5],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Select Product Image",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            textField(
                text: "Product name",
                maxLines: 1,
                nameController: nameController),
            SizedBox(height: 20),
            textField(
                text: "Product description",
                maxLines: 10,
                nameController: descriptionController),
            SizedBox(height: 20),
            textField(
              text: "Product price",
              maxLines: 1,
              nameController: priceController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            textField(
              text: "Quantity",
              maxLines: 1,
              nameController: quantityController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category"),
                  DropdownButton<String>(
                    iconSize: 20,
                    elevation: 5,
                    enableFeedback: true,
                    value: category,
                    items: productCategories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        category = val!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (images.isNotEmpty &&
                    nameController.text != "" &&
                    descriptionController.text != "" &&
                    priceController.text != "" &&
                    quantityController.text != "") {
                  admin.sellProduct(
                      context: context,
                      productname: nameController.text,
                      description: descriptionController.text,
                      price: int.parse(priceController.text),
                      quantity: int.parse(quantityController.text),
                      category: category,
                      images: images);
                } else{
                  showSnackBar(context, "Fill all fields");
                }
              },
              child: Buttons(
                text: "Sell",
                boxColor: globalVariables.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class textField extends StatelessWidget {
  textField({
    required this.nameController,
    this.maxLines = 1,
    this.text = "",
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController nameController;
  final int maxLines;
  final String text;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: nameController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: globalVariables.lightBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: 2,
            color: globalVariables.lightBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: globalVariables.lightBlack,
            width: 3,
          ),
        ),
      ),
    );
  }
}
