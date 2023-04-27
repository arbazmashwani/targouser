import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/Utilities/widgets/extentions.dart';
import 'package:tragoo_app/screens/HomePage.dart';

import '../constants/TitleText.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          WidgetItems(
              title: 'all_products'.tr,
              image: "images/trago.png",
              onTapfunction: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageUpdated('our_products'.tr)));

              }),
          WidgetItems(
              title: 'cigarette'.tr,
              image: "images/img_11.png",
              onTapfunction: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageUpdated('cigarette'.tr)));
              }),
          WidgetItems(
            title: 'beer'.tr,
            image: "images/img_7.png",
            onTapfunction: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageUpdated('beer'.tr)));

            },
          ),
          WidgetItems(
              title: 'liquor'.tr, image: "images/img_9.png", onTapfunction: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageUpdated('liquor'.tr)));
            print("Liquor");
          }),


        ],
      ),
    );
  }
}

class WidgetItems extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTapfunction;
  WidgetItems(
      {required this.title, required this.image, required this.onTapfunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryClr,
      onTap: onTapfunction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,),
            alignment: Alignment.center,

            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Image.asset(
                  image,
                  width: 30,
                  height: 50,
                ),
                SizedBox(),
                Container(
                  child: TitleText(
                    text: title.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
              ],
            ))
      )
    );
  }
}
