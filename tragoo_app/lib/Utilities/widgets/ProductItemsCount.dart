
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/TitleText.dart';

class ItemsCount extends StatefulWidget {
 final double fontSize ;
 final Color color;
 const  ItemsCount({super.key,  required this.fontSize, required this.color}) ;
  @override
  State<ItemsCount> createState() => _ItemsCountState();
}

class _ItemsCountState extends State<ItemsCount> {
  final CollectionReference _userRef = FirebaseFirestore.instance.collection('Users');
  final User? _user = FirebaseAuth.instance.currentUser;
  int totalItems = 1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userRef.doc(_user?.uid).collection('cart').snapshots(),
      builder:  (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

        if(streamSnapshot.connectionState == ConnectionState.active)
        {
          List documents = streamSnapshot.data!.docs;
          totalItems=  documents.length;
          print("*****************************************");
          print(totalItems);
        }
        return Center(
          child: TitleText(text: "$totalItems",fontSize: widget.fontSize,color: widget.color,)
          /*Text(
            "${totalItems}",
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize
            ),*/

        );
      },
    );
  }
}



