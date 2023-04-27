import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/Utilities/widgets/searchBar.dart';

import '../Utilities/widgets/ProductItemWidget.dart';
import '../Utilities/widgets/searchItemWidget.dart';

class SearchScreen extends StatefulWidget {
  final String searchString;
  SearchScreen({required this.searchString});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Icons.arrow_back_outlined,color: Colors.blue[900]
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined, color:kPrimaryClr)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: Color(0xFFEDECF2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            )),
        child: ListView(
          children: [
            SearchBar(),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
                child: Text(
              "search_results_for".tr+"${widget.searchString.toUpperCase()}",
              style: TextStyle(
                  color: kPrimaryClr,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: searchItemWidgets(searchString: widget.searchString,),
            )
          ],
        ),
        //
      ),
    );
  }
}
