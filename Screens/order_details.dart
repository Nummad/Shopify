// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import "package:ecommerce/constants/global_variables.dart";
import "package:ecommerce/services/buyer_services.dart";
import "package:ecommerce/widgets/customTextField.dart";
import "package:ecommerce/widgets/sign-up%20sign-in%20button.dart";
import "package:ecommerce/widgets/snackBar.dart";
import "package:flutter/material.dart";
import "package:flutter_sizer/flutter_sizer.dart";
import "package:quickalert/models/quickalert_type.dart";
import "package:quickalert/widgets/quickalert_dialog.dart";

class OrderDetails extends StatefulWidget {
  String imageUrl;
  String productName;
  String productDescription;
  int productQunatity;
  int productPrice;
  OrderDetails({
    required this.imageUrl,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.productQunatity,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Buyer buyer = Buyer();

  TextEditingController buyerName = TextEditingController();

  TextEditingController buyerPhone = TextEditingController();

  TextEditingController buyerAddress = TextEditingController();

  int orderedQuantity = 0;

  void showAlert(
      BuildContext context,
      String name,
      String description,
      int price,
      int quantity,
      String images,
      String buyerName,
      String buyerAddress,
      String buyerPhone) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Placing order!!!',
      text: 'Are you sure you want to buy $name for $price?',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.green),
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.red),
      onConfirmBtnTap: () {
        buyer.buyProduct(
          context: context,
          productname: name,
          description: description,
          price: price,
          quantity: quantity,
          images: images,
          buyerAddress: buyerAddress,
          buyerName: buyerName,
          buyerPhone: buyerPhone,
        );
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Details"),
            Text("Bill : ${widget.productPrice * orderedQuantity}"),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
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
                      child: Image(image: NetworkImage(widget.imageUrl))),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productName.length > 13
                            ? widget.productName.substring(0, 12) + "..."
                            : widget.productName,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        widget.productPrice.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.productDescription,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              // margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: globalVariables.lightBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        orderedQuantity.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (orderedQuantity > 0) {
                            setState(() {
                              orderedQuantity -= 1;
                            });
                          }
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: globalVariables.darkBlack,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20,
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            orderedQuantity += 1;
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: globalVariables.darkBlack,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: buyerName,
              color: globalVariables.lightBlack,
              text: "Your name",
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: buyerPhone,
              color: globalVariables.lightBlack,
              text: "Your phone number",
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            CustomTextField(
                controller: buyerAddress,
                color: globalVariables.lightBlack,
                text: "Your address"),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                if (buyerName.text != "" &&
                    buyerAddress.text != "" &&
                    orderedQuantity != 0) {
                  if (orderedQuantity <= widget.productQunatity) {
                    showAlert(
                        context,
                        widget.productName,
                        widget.productDescription,
                        widget.productPrice * orderedQuantity,
                        orderedQuantity,
                        widget.imageUrl,
                        buyerName.text,
                        buyerAddress.text,
                        buyerPhone.text);
                  } else {
                    showSnackBar(context,
                        "Total available items are ${widget.productQunatity}");
                  }
                } else {
                  showSnackBar(context, "Fill all fields or check quantity");
                }
              },
              child: Buttons(
                text: "Place order",
                boxColor: globalVariables.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
