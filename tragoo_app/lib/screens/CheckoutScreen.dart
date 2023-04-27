import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import '../Utilities/constants/TitleText.dart';
import 'PaymentScreen.dart';


class CheckOutScreen extends StatefulWidget {
  final double total;
  final List cartItemsList;


  const CheckOutScreen({super.key, required this.total, required this.cartItemsList});
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController addressCont1 = TextEditingController();
  TextEditingController addressCont2 = TextEditingController();
  TextEditingController countryCont = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController postalCodeCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  int _value = 1;
  String firstName = '';
  String addressline1 = '';
  String lastName = '';
  String addressline2 = '';
  String state = "";
  String city = "";
  String postalCode = "";
  String phoneNumber = "";
  final formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference userRef =
  FirebaseFirestore.instance.collection('Users');
  late Map<String , dynamic> CheckOutMap ;

  void addToCheckout()

  {
    print("Checkout");

    CheckOutMap = {
      "firstName": firstName,
      "lastName": lastName,
      "address":addressline1 + addressline2,
      "state ":state ,
      "city": city,
      "postalCode":postalCode,
      "phoneNumber":phoneNumber,
      "totalPrice":widget.total
    };


   /* return userRef.doc(user?.uid).collection('checkout').doc(user?.uid).update({
      "firstName": firstName,
      "lastName": lastName,
      "address":addressline1 + addressline2,
      "country ":country ,
      "city": city,
      "postalCode":postalCode,
      "phoneNumber":phoneNumber,
      "totalPrice":widget.total

    });*/
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cartItemsList);
    Map<String, dynamic> ? paymentIntentData;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    Widget title() {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    text: 'shipping_address'.tr,
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ));
    }

    Widget _submitForm() {
           return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: firstNameCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'first_name'.tr
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return  'please_enter_your_first_name'.tr;
                    }
                  },
                  onSaved: (value) {
                    firstName = value!;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_your_last_name'.tr;
                    }
                  },
                  onSaved: (value) {
                    lastName = value!;
                  },
                  controller: lastNameCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'last_name'.tr
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return 'Please_valid_phone_number'.tr;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                  controller: phoneCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'phone'.tr
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_the_address'.tr;
                    }
                  },
                  onSaved: (value) {
                    addressline1 = value!;
                  },
                  controller: addressCont1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'enter_your_address'.tr
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_the_state'.tr;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    state = value!;
                  },
                  controller: countryCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'enter_state'.tr
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_the_city_name'.tr;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    city = value!;
                  },
                  controller: cityCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'city'.tr
                  ),
                ),
                SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_the_zip_code'.tr;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    postalCode = value!;
                  },
                  controller: postalCodeCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEDECF2),
                      hintText: 'enter_the_zip_code'.tr
                  ),
                ),

                SizedBox(height: 10,),
                TextButton(
                  onPressed: () {
                    final isvalid = formKey.currentState!.validate();
                    if (isvalid) {
                      formKey.currentState!.save();
                      addToCheckout();
                      print(widget.total.toString());
                      print(CheckOutMap);

                        FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection("checkOut").doc(user?.uid).set(
                            {
                              "checkOut": CheckOutMap
                            }
                        ).then((value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  PaymentScreen( price: widget.total, cartItems: widget.cartItemsList, )));
                        });
                        setState(() {
                         bool isLoading = true;
                        });


                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryClr),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .8,
                    child: TitleText(
                      text: 'order_now'.tr,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ],
            ),
          ));
    }


    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.transparent,
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
                title(),
                Divider(
                  thickness: 3,
                ),
               SizedBox(height: 20,),
                _submitForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  creatPaymentIntent(String amount, String currency) {
  }
}
