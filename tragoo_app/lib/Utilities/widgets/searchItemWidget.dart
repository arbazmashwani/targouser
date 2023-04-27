import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tragoo_app/Utilities/widgets/productCard.dart';

class searchItemWidgets extends StatefulWidget {
 final String searchString ;
  const searchItemWidgets({Key? key, required this.searchString}) : super(key: key);

  @override
  State<searchItemWidgets> createState() => _searchItemWidgetsState();
}

class _searchItemWidgetsState extends State<searchItemWidgets> {
  final CollectionReference productRef =
  FirebaseFirestore.instance.collection('products_details');
  @override
  Widget build(BuildContext context) {
    print(widget.searchString);
    return FutureBuilder<QuerySnapshot>(
      //productRef.orderBy('search_string').startAt([widget.searchString]).endAt(["$widget.searchString\uf8ff"]).get(),
        future: productRef.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
           // List documents = snapshot.data!.docs;
            print("+++++++++++++++++++++++");
            List documents= snapshot.data!.docs.where((s) => s['search_string'].toLowerCase().contains(widget.searchString)).toList();
            print(documents.length);
            return documents.length != 0 ?  GridView.count(
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
                })
            ) : Center(child: Container(
              child: Text(
                "NOT FOUND",style: TextStyle(
                 fontSize: 20,color: Colors.black
              ),
              ),
            ),);
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
