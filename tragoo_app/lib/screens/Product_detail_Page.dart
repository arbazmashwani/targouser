import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/screens/cart_page.dart';
import '../Utilities/constants/TitleText.dart';
import '../Utilities/widgets/ProductItemsCount.dart';

int  selectedPack = 0;
final CollectionReference _userRef = FirebaseFirestore.instance.collection('Users');
User? _user = FirebaseAuth.instance.currentUser;

class productDescription extends StatefulWidget {
  String productId;
  List images;
  String Title;
  double Price;
  String description;

  productDescription(
      {Key? key,

      required this.images,
      required this.productId,
      required this.Title,
      required this.Price,
      required this.description})
      : super(key: key);

  @override
  State<productDescription> createState() => _productDescriptionState();
}

class _productDescriptionState extends State<productDescription> {

  final SnackBar _snackBar = SnackBar(content: Text('product_Added_to_the_cart'.tr));
  Future addToCart()
  {
    return _userRef.doc(_user?.uid).collection('cart').doc(widget.productId).set({
      "selectedPack": selectedPack,
      "Price": widget.Price,
      "Title":widget.Title,
      "Images":widget.images[0],
      "Quantity": 1,
      "productId":widget.productId

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ImageSwipe(
            images: widget.images,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child:TitleText(text: widget.Title,fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,)

            ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(

                      children: <Widget>[
                        TitleText(text: "\$ ",fontSize:18 ,color: Colors.red,fontWeight: FontWeight.bold),
                        TitleText(text: "${widget.Price.toInt().toString()}",fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)

                      ],

                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,
                            color: Colors.yellow, size: 17),
                        Icon(Icons.star,
                            color: Colors.yellow, size: 17),
                        Icon(Icons.star,
                            color: Colors.yellow, size: 17),
                        Icon(Icons.star,
                            color: Colors.yellow, size: 17),
                        Icon(Icons.star_border, size: 17),
                      ],
                    )
                  ],
                ),
              ),

            ]
          ),
          Padding(
              padding:EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child: TitleText(text: 'available_pack'.tr,fontSize: 17,)
            //Text("Available Pack ",style:GoogleFonts.mulish(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
            child: Row(
              children:<Widget> [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedPack = 12;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffa8a09b),
                            style: selectedPack == 24 || selectedPack == 0? BorderStyle.solid : BorderStyle.none),
                        boxShadow: [BoxShadow(
                            color: Color(0xfff8f8f8),
                            blurRadius: 5,
                            spreadRadius: 10,
                            offset: Offset(5, 5)),
                        ],
                        borderRadius: BorderRadius.circular(13),
                        color: selectedPack == 12 ? kPrimaryClr : Color(0XFFFFFFFF)
                    ),
                    child:Center(child: TitleText(text: '12',fontSize: 20,color: selectedPack == 12 ? Colors.white:Colors.black,)),

                  ),
                ),
                SizedBox(width: 15,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedPack = 24;
                    });

                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffa8a09b),
                            style: selectedPack == 12 || selectedPack == 0? BorderStyle.solid : BorderStyle.none),
                        boxShadow: [BoxShadow(
                            color: Color(0xfff8f8f8),
                            blurRadius: 5,
                            spreadRadius: 10,
                            offset: Offset(5, 5)),
                        ],
                        borderRadius: BorderRadius.circular(13),
                        color: selectedPack == 24 ? Colors.blue[900] :Color(0XFFFFFFFF)
                    ),
                    child: Center(child: TitleText(text: '24',fontSize: 20,color: selectedPack == 24 ? Colors.white:Colors.black,)),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding:EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child: TitleText(text: 'product_description'.tr,fontSize: 17,)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
            child: TitleText(text: widget.description,fontWeight: FontWeight.normal,fontSize: 14,),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            onPressed: () async{
              await addToCart();
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryClr),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4),
              width: MediaQuery.of(context).size.width * .75,
              child: TitleText(
                text: 'add_to_cart'.tr,
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

          /*GestureDetector(
            onTap: () async{
             await addToCart();
             ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Center(child: TitleText(text: 'ADD TO CART',color: Colors.white,)),
                height: 50,
                width:12,
                decoration: BoxDecoration(

                 border: Border.all(
                      color: Color(0xffa8a09b),
                      style:  BorderStyle.solid ),
                  boxShadow: [BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 5,
                      spreadRadius: 10,
                      offset: Offset(5, 5)),
                  ],
                    borderRadius:BorderRadius.circular(10) ,
                    color:   Colors.blue[900],
                ),
              ),
            ),
          ),*/

        ],
      ),
    );
  }
}

class ImageSwipe extends StatefulWidget {
  List images;
  ImageSwipe({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageSwipe> createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int selectedPage = 0;
  int? totalItems ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Stack(children: [
        PageView(
          onPageChanged: (num) {
            setState(() {
              selectedPage = num;
            });
          },
          children: [
            for (var i = 0; i < widget.images.length; i++)
              Container(
                child: Image.network(
                  widget.images[i],
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.images.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: selectedPage == i ? 24 : 12,
                  height: selectedPage == i ? 24 : 12,
                  decoration: BoxDecoration(
                      color:
                          selectedPage == i ? Colors.blue[900] : Colors.blue[700],
                      borderRadius: BorderRadius.circular(12)),
                ),
            ],
          ),
        ),
        Positioned(
            top:30,
            left: 20,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
               decoration: BoxDecoration(
                  border: Border.all(
                      color:Color(0xffa8a09b),
                      style:  BorderStyle.solid ),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color:
                   kPrimaryClr ,

                ),
                height: 50,
                width: 50,

                child: Center(
                    child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                )),

              ),
            )),
        Positioned(
          top: 30,
          right: 20,
          child:
          /*Badge(
            badgeColor: Colors.red,
            badgeContent: ItemsCount(fontSize: 16, color: Colors.white,),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> cartPage()));
              },
              child: Icon(Icons.shopping_cart,size:50,color: Colors.blue.shade900,),

            ),
          )*/

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> cartPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:Color(0xffa8a09b),
                    style:  BorderStyle.solid ),
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color:
                kPrimaryClr ,

              ),
              height: 50,
              width: 50,
              child: Center(child: ItemsCount(fontSize: 22, color: Colors.white,))

            ),
          ),
        ),
      ]),
    );
  }
}



