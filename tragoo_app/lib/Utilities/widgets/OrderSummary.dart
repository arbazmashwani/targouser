import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/TitleText.dart';

class OrderSummary extends StatefulWidget {
  final double subtotal;
  OrderSummary({ required this.subtotal});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: 'subtotal'.tr,fontSize: 20, fontWeight: FontWeight.w500),
              Row(
                children: <Widget>[
                  TitleText(
                    text: '\$ ',
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  TitleText(
                    text: "${widget.subtotal}",
                    fontSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: 'delivery_fee'.tr,fontSize: 20, fontWeight: FontWeight.w500),
              Row(
                children: <Widget>[
                  TitleText(
                    text: '\$ ',
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  TitleText(
                    text: "20",
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Stack(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total".tr,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500,color: Colors.white),
                        ),
                        Text(
                          "\$${(widget.subtotal+20).toString()}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                        ),
                      ]),
                ))
          ],
        )
      ],
    );
  }
}
