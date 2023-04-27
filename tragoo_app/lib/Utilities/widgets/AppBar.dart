import 'package:flutter/material.dart';

import '../../screens/cart_page.dart';

import 'ProductItemsCount.dart';

class homeAppBar extends StatefulWidget {
  final VoidCallback onPressed;
  const homeAppBar({super.key, required this.onPressed});
  @override
  State<homeAppBar> createState() => _homeAppBarState();
}

class _homeAppBarState extends State<homeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: Color(0XFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 15),
                ]),
            child: IconButton(
              icon: const Icon(Icons.sort, size: 30, color: Colors.black),
              onPressed: widget.onPressed,
            ),
          ),
          Image.asset(
            'images/trago.png',
            width: 70,
            height: 70,
          ),
          // Text(" TRAGO ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blue[900]),),
          Badge(
            backgroundColor: Colors.red,
            // badgeContent: const ItemsCount(fontSize: 16, color: Colors.white,),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => cartPage()));
              },
              child: const Icon(
                Icons.shopping_cart,
                size: 32,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
