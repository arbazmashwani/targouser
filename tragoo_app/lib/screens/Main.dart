import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/screens/cart_page.dart';
import 'SearchScreen.dart';
import 'HomePage.dart';


class MyNewHomePage extends StatefulWidget {
  const MyNewHomePage({Key? key}) : super(key: key);

  @override
  State<MyNewHomePage> createState() => _MyNewHomePageState();
}

class _MyNewHomePageState extends State<MyNewHomePage> {

    int index = 0;
    final screens = [

    HomePageUpdated('our_products'.tr),
    cartPage(),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  HomePageUpdated('our_products'.tr),
     /* bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        index: index,
        color: Colors.blue.shade900,
        backgroundColor: Colors.transparent,
        onTap: (index){
         setState(() {
           this.index = index;
         });
        },
        items: [

          Icon(CupertinoIcons.search,size: 20,color: Colors.white,),
          Icon(Icons.home,size: 20,color: Colors.white,),
          Icon(CupertinoIcons.cart_fill,size: 20,color: Colors.white,),
        ],

      ),*/
    );
  }
}





