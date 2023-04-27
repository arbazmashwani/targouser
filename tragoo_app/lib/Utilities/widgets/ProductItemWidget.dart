import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tragoo_app/Utilities/widgets/productCard.dart';
import '../../screens/Product_detail_Page.dart';

class ProductItemWidget extends StatefulWidget {
  final String category;
  const ProductItemWidget(this.category) : super();

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('products_details');
  List documents = [];
  @override
  Widget build(BuildContext context) {
    print(widget.category);
    return FutureBuilder<QuerySnapshot>(
        future: productRef.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('++++++++++++++++++++++');
            print(widget.category);
            if(widget.category == 'Our Products')
              {
                documents = snapshot.data!.docs;
                print('yes');
              }
            else
              {
                print('no');
                documents= snapshot.data!.docs.where((s) => s['category'].contains(widget.category)).toList();
              }
            //documents= snapshot.data!.docs.where((s) => s['category'].contains(widget.category)).toList();

            return GridView.count(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                childAspectRatio: 0.68,
                padding: EdgeInsets.symmetric(vertical: 30),
                children: List.generate(documents.length, (index) {
                  return productCard(
                    Title: documents[index]['Title'],
                    price: documents[index]['Price'],
                    url: documents[index]['ImageList'],
                    description: documents[index]['description'],
                    productId: documents[index]['productId'],
                    index: index,
                  );
                }));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}




