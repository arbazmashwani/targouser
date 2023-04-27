import 'package:flutter/material.dart';

import '../Utilities/constants/TitleText.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key, required this.OrderDetails, required this.index}) : super(key: key);
  final List OrderDetails;
  final int index;
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(text: "Order",color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,),
                        TitleText(text:"#"+ widget.OrderDetails[widget.index]['OrderNumber'],color: Colors.blue,fontSize: 28,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(text: "Status",color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,),
                        TitleText(text: widget.OrderDetails[widget.index]['status'],color: Colors.orange,fontSize: 28,),
                      ],
                    ),
                  ),
                ],
              ),

              DetailCard()
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
                  text:  'Order Details',
                  fontSize: 29,
                  fontWeight: FontWeight.w800,

                ),
              ],
            ),

          ],
        ));
  }
  Widget DetailCard() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade50
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TitleText(text: "Product"),
                TitleText(text: "Qty"),
                TitleText(text: "Total")
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(

                itemCount: widget.OrderDetails[widget.index]['OrderList'].length,
                shrinkWrap:true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              children: [
                                ConstrainedBox(
                                    constraints: BoxConstraints.expand(height: 60, width:60),
                                    child: Image.network(widget.OrderDetails[widget.index]['OrderList'][index]['Images']) //,
                                ),
                                TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Title'],fontWeight: FontWeight.normal,),
                                TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Quantity'].toString(),fontWeight: FontWeight.normal,),
                                TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Price'].toString(),fontWeight: FontWeight.normal,)
                              ]
                          )
                        ],
                      )

                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.red.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TitleText(text: "Total = ",fontWeight: FontWeight.normal,),
                TitleText(text: "\$"+ widget.OrderDetails[widget.index]['TotalPrice'].toString(),fontSize:30,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
