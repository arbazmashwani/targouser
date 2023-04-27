import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/SearchScreen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String serachvalue = '';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Icon(Icons.search,size: 27,color: Colors.black,),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 5),
            height: 50,
            width: 300,
            child: TextFormField(
              onFieldSubmitted: (value){
                serachvalue = value.toLowerCase();
                print(value);
                if(value.isNotEmpty)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen(searchString: serachvalue)));
                  }

              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'search_products'.tr
              ),
            ),
          ),

        ],
      ),
    );
  }
}
