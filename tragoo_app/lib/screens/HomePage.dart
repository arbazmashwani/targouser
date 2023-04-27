import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/Utilities/widgets/Drawer.dart';
import 'package:tragoo_app/Utilities/widgets/searchBar.dart';

import '../Utilities/constants/TitleText.dart';
import '../Utilities/widgets/AppBar.dart';
import '../Utilities/widgets/CategoryWidget.dart';
import '../Utilities/widgets/ProductItemWidget.dart';
import '../Utilities/widgets/ProductItemsCount.dart';
import 'SearchScreen.dart';

class HomePageUpdated extends StatefulWidget {
  String category ;
  HomePageUpdated( this.category);

  @override
  State<HomePageUpdated> createState() => _HomePageUpdatedState();
}

class _HomePageUpdatedState extends State<HomePageUpdated> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
 String searchCategory = '';
  @override
  void initState() {
    // TODO: implement initState
    print("INIT STATE CALLED ++++++++++++");
    super.initState();
    print(widget.category);
    if(widget.category == 'Cigarrillo')
      {
        searchCategory = "Cigarette";
      }
    else if(widget.category == 'Nuestros Productos')
    {
      searchCategory = "Our Products";
    }
    else if(widget.category == 'Cerveza')
    {
      searchCategory = "Beer";
    }
    else if(widget.category == 'Espíritu')
    {
      searchCategory = 'Liquor';
    }
    else{
      searchCategory = widget.category;
    }
  }
  @override
  Widget build(BuildContext context) {
    print(searchCategory);
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: CustomDrawer()
      ),
      body: ListView(
        children: [
          homeAppBar(onPressed: () {_globalKey.currentState!.openDrawer(); },),
          Container(
            //temp height
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
          color: Color(0xFFEDECF2),
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //Search Bar
                SearchBar(),

                SizedBox(height: 10,),
                CategoryWidget(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child:TitleText(text:widget.category,fontSize: 27,color:kPrimaryClr,fontWeight: FontWeight.w600,)

                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: ProductItemWidget(searchCategory),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
