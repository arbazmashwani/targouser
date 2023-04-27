

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/Utilities/widgets/extentions.dart';
import 'package:tragoo_app/screens/PaymentScreen.dart';
import '../Utilities/constants/TitleText.dart';
import '../Utilities/widgets/AppBar.dart';
import '../Utilities/widgets/OrderSummary.dart';
import '../services/database_services.dart';
import 'CheckoutScreen.dart';

User? user = FirebaseAuth.instance.currentUser;

class cartPage extends StatefulWidget {

  cartPage({
    Key? key,

  }) : super(key: key);
  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('Users');
  DatabaseServices databaseServices = DatabaseServices();
  double total = 0;
  List finalList =[];
   int length=0;



  @override
  void initState() {


    setState(() {
    });
    super.initState();
  }

  void deleteFromCart(String productID) async {
    String msg = await databaseServices.deleteCartItem(productID);
    print(msg);
    setState(() {});
  }

  void UpdateQuantity(productId, quantity) async {
    print("UPDATE QUANTITY FUNCTION CALLED");
    print(quantity);

    String msg = await databaseServices.UpdateCartItemQuantity(productId, quantity);
    print(msg);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("in context");
    print(length);
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: 
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TitleText(text: 'shipping_flat_rate_You_can_swipe_to'.tr,fontWeight: FontWeight.normal,),
                  ),
                  _CartItemsBuilder(),

                ]
              )

            ),
          ),
        ),
        bottomNavigationBar: StreamBuilder(
            stream: userRef.doc(user?.uid).collection('cart').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if(snapshot.connectionState == ConnectionState.active)
              {
                List documents =  snapshot.data!.docs;
                print(documents.length);
                for(int i=0; i<documents.length;i++)
                {
                  double price = documents[i]['Quantity']*documents[i]['Price'];
                  total+=price;
                  print(total);
                }

              }
              return total > 0 ? checkOutCard(total: total, cartList: finalList, length: length,) : Container(height: 5,width: 5,);
            }
       /* bottomSheet: Padding(
          padding: const EdgeInsets.all(10.0),
    child: SizedBox(
    height: MediaQuery.of(context).size.height *0.2,
    child: StreamBuilder(
    stream: userRef.doc(user?.uid).collection('cart').snapshots(),
    builder: (BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    if(snapshot.connectionState == ConnectionState.active)
    {
    List documents =  snapshot.data!.docs;
      print(documents.length);
      for(int i=0; i<documents.length;i++)
        {
          double price = documents[i]['Quantity']*documents[i]['Price'];
          total+=price;
          print(total);
        }
    }
     return OrderSummary(subtotal: total);
    }

    ),
    ),
    )*/
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
                  text:  'shopping'.tr,
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text:  'Cart',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),

          ],
        ));
  }
  FutureBuilder<QuerySnapshot<Object?>> _CartItemsBuilder() {
    return FutureBuilder<QuerySnapshot>(
                future: userRef.doc(user?.uid).collection('cart').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("ERROR LOADING........"));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    total = 0;
                    final allData = snapshot.data!.docs.map((doc) => doc.data()).toList();
                    print("+++++++++++++++++++++++++++++++++++");
                     finalList = allData.toList();
                    print(finalList);
                    return snapshot.data!.docs.length > 0 ? Column(
                        children: snapshot.data!.docs.map((document) {
                      return Container(
                        padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          key: Key(document['productId'].toString()),
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50
                              //Color(0XFFFFE6E6),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                          onDismissed: (direction){
                            var productId = document['productId'];
                            deleteFromCart(productId);
                          },
                          child: Container(
                            height: 80,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: FittedBox(child: Image.network(document['Images'],fit: BoxFit.cover,)),
                                ),
                                Expanded(
                                    child: ListTile(
                                        title: TitleText(
                                          text: document['Title'],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            TitleText(
                                              text: '\$ ',
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                            TitleText(
                                              text: document['Price'].toInt().toString(),
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        trailing: Container(
                                          width: 35,
                                          height: 35,
                                         alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color:Color(0xffE1E2E4).withAlpha(150),
                                              borderRadius: BorderRadius.circular(10)),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:  document['Quantity'].toString(),
                                              prefixText: "x",
                                              hintStyle: GoogleFonts.mulish(
                                                  fontSize: 12, fontWeight: FontWeight.bold,)
                                              ),

                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            onSubmitted: (value) {
                                               setState(() {
                                                 var productId = document['productId'];
                                                 UpdateQuantity(productId, int.parse(value));
                                               });


                                            },
                                          ),
                                        ))),

                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList()) : Center(child: Container(child: Image.asset('images/confusing-woman-due-to-empty-cart-4558760-3780056.png'),));
                  }
                  return Center(child: CircularProgressIndicator());
                });
  }
}
/*
  OrderSummary(subtotal: 20,)+
*/

/*
StreamBuilder(
stream: userRef.doc(user?.uid).collection('cart').snapshots(),
builder: (BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
if(snapshot.connectionState == ConnectionState.active)
{
var total  = snapshot.data!.docs.map((document){
print(document['Price']);
print(document['Quantity']);
double subtotal = document['Price'] * document['Quantity'];
print(subtotal);

});

}
return OrderSummary(subtotal: 20);
},

 Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  document['Title'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text("\$" + document['Price'].toString()),
                                Text(
                                    "Pack:" + document['selectedPack'].toString())
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                print(document['productId']);
                                var productId = document['productId'];
                                var quantity = document['Quantity'];
                                quantity = quantity + 1;
                                UpdateQuantity(productId, quantity);
                                print(quantity);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Icon(Icons.add),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                document['Quantity'].toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                var quantity = document['Quantity'];
                                var productId = document['productId'];
                                if (quantity > 1) {
                                  quantity = quantity - 1;
                                  UpdateQuantity(productId, quantity);
                                  print(quantity);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white),
                                // Image.asset('images/pngegg.png')
                                child: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      var productId = document['productId'];
                                      deleteFromCart(productId);
                                      setState(() {

                                      });
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),


));*/


class checkOutCard extends StatefulWidget{
  final double total ;
  final List cartList;
  final int length;
 checkOutCard({ required this.total, required this.cartList, required this.length});
  @override
  State<checkOutCard> createState() => _checkOutCardState();
}

class _checkOutCardState extends State<checkOutCard> {
  int lenght2 = 0;
  void getLength() async
  {
    var docSnapshot = await FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("checkOut").get();
    lenght2 = docSnapshot.docs.length;
    print("********************************************************************************");
    print(lenght2);
  }

  @override
  Widget build(BuildContext context) {
    double price = widget.total + 20;
    return Container(
      height:  MediaQuery.of(context).size.height *  0.2,
      width: MediaQuery.of(context).size.width *  0.2,
      child:

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Divider(
                thickness: 3,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TitleText(
                        text: "subtotal".tr,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,

                      ),

                      Row(
                        children: <Widget>[
                          TitleText(
                            text: '\$',
                            color: Colors.red,
                            fontSize: 16,
                          ),
                          TitleText(
                            text: widget.total.toInt().toString(),
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TitleText(
                        text: 'Total: ',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,

                      ),

                      Row(
                        children: <Widget>[
                          TitleText(
                            text: '\$',
                            color: Colors.red,
                            fontSize: 16,
                          ),
                          TitleText(
                            text: price.toInt().toString(),
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
             TextButton(
          onPressed: () {
            print("***************FUNCTION CALLED*****************");
            FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection('checkOut').get().then((snapshot)  {
              print(snapshot.docs.length );
              if(snapshot.docs.length == 1 )
                   {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen(price: widget.total+20, cartItems: widget.cartList)));
                   }
                 else
                   {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOutScreen(total: widget.total+20, cartItemsList: widget.cartList,)));
                   }
            });
            setState(() {
              bool isLoading = true;
            });




        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryClr),
        ),
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 4),
            width: MediaQuery.of(context).size.width  * .8,
            child: TitleText(
              text: 'continue'.tr,
              color:Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),

        ],
      ),
    );
  }
}
