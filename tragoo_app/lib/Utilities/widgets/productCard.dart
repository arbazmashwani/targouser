import 'package:flutter/material.dart';

import '../../screens/Product_detail_Page.dart';
import '../constants/TitleText.dart';

class productCard extends StatelessWidget {
  int index;
  String productId;
  String Title;
  double price;
  List url;
  String description;
  productCard(
      {Key? key,
        required this.index,
        required this.Title,
        required this.price,
        required this.url,
        required this.description,
        required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  productDescription(images: url, Title: Title, Price: price, description: description, productId: productId,)),
                        );
                      },
                      child: Image.network(
                        url[0],
                        fit: BoxFit.cover,
                      )),
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text:  Title, fontSize: 16,fontWeight: FontWeight.normal,),
                        TitleText(text:  "\$" + price.toInt().toString(), fontSize: 16,color: Colors.red,),
                        /*Text(
                          Title,
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),*/
                       /* Text(
                          "\$" + price.toInt().toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),*/
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );

    /*Material(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  productDescription(images: url, Title: Title, Price: price, description: description, productId: productId,)),
          );
        },
        child:*/

    // ),
    //   );
  }
}