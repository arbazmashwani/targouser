import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/constants/TitleText.dart';
import 'order_details_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final CollectionReference userRef =
  FirebaseFirestore.instance.collection('Users');
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color:
                      Colors.transparent ,

                    ),
                    height: 50,
                    width: 50,

                    child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        )),


                  ),
                ),
              ),
              _title(),
              FutureBuilder<QuerySnapshot>(
                future: userRef.doc(user?.uid).collection('OrderHistory').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("ERROR LOADING........"));
                  }
                  if(snapshot.connectionState == ConnectionState.done)
                    {
                      List data = snapshot.data!.docs.toList();

                      return Column(
                        children: [
                          Container(
                            height: 50,
                            color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Table(
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      TitleText(text: "OrderID"),
                                      TitleText(text: "Date"),
                                      TitleText(text: "Price"),
                                      TitleText(text: "Status")
                                    ]
                                  )

                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index)
                              {
                                String date =  data[index]['Time'];
                                print(date);
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blue
                                      ),
                                      borderRadius: BorderRadius.circular(5)
                                  ),

                                  child: GestureDetector(
                                    onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderDetailsPage(OrderDetails: data, index: index,)));
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            children: [
                                              TitleText(text: " #"+data[index]['OrderNumber'],fontWeight: FontWeight.normal,),
                                              TitleText(text: data[index]['Time'],fontWeight: FontWeight.normal,fontSize: 12,),
                                              TitleText(text: "\$"+data[index]['TotalPrice'].toString(),fontWeight: FontWeight.normal),
                                              TitleText(text: data[index]['status'].toString(),fontWeight: FontWeight.normal,color: Colors.orange,),
                                            ]
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ],
                      );
                    }


                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _title() {
    return Container(
        margin:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text:  'Order History',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),

          ],
        ));
  }

}
/*Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blue
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),

                              color: Colors.white,
                              child: ListTile(

                                leading: TitleText(text: "Order #"+data[index]['OrderNumber'],),
                                title: TitleText(text: data[index]['Time']),
                                subtitle: TitleText(text: "\$"+data[index]['TotalPrice'].toString()),
                                trailing: TitleText(text: data[index]['status'].toString()),
                              ),
                            );*/