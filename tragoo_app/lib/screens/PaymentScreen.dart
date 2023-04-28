import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/screens/CheckoutScreen.dart';
import 'package:tragoo_app/services/sendnotifications.dart';
import '../Utilities/constants/TitleText.dart';
import 'Main.dart';
import 'cart_page.dart';
import 'dart:math';
import 'package:intl/intl.dart';

String SECRET_KEY =
    'sk_test_51JeXmMKqM4h5Xm0EXPka9qTexXPG0sDuLQh0tTrqT8AZ2Nfj94lgf6V7dtolzdVVyn36HdHMTgNhDOYJq7UvFn7P00HGSzQRea';

class PaymentScreen extends StatefulWidget {
  final double price;
  final List cartItems;

  const PaymentScreen({
    Key? key,
    required this.price,
    required this.cartItems,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Users');
  int _value = 0;
  String phoneNumberForRider = "";
  String messageForRider = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPhoneNumber = TextEditingController();
  TextEditingController newMessage = TextEditingController();
  bool isLoading = false;
  late Map<String, dynamic> CheckOutMap;

  String getCurrentDate() {
    var time = DateTime.now();
    String timeNow =
        "${DateFormat('Hms').format(time)} ${DateFormat('yMMMMd').format(time)}";
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(timeNow);
    print(user!.email);
    return timeNow;
  }

  String getOrderNumber() {
    String rndnumber = "";
    var rnd = Random();
    for (var i = 0; i < 4; i++) {
      rndnumber = rndnumber + rnd.nextInt(99).toString();
    }
    print(rndnumber);
    return rndnumber;
  }

  Future<List> getData() async {
    print("&&&&&&&&&&&*******************************&&&&&&&&&&&&&");
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.doc(user!.uid).collection("cart").get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    print("ENDDDDDDDDDDDDDDDDDDDD");
    return allData;
  }

  Map<String, dynamic>? paymentIntent;
  Widget _title() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: 'continue'.tr,
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: 'shopping'.tr,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cartItems);
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100,
                      ),
                      TitleText(
                        text: 'your_order_is_confirmed'.tr,
                        fontSize: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyNewHomePage()));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryClr),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            width: MediaQuery.of(context).size.width * .8,
                            child: TitleText(
                              text: 'back_to_home_page'.tr,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            color: Colors.transparent,
                          ),
                          height: 50,
                          width: 50,
                          child: const Center(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => cartPage()));
                              },
                              child: TitleText(
                                text: 'show_order_summary'.tr,
                                color: kPrimaryClr,
                              )),
                          TitleText(
                            text: "\$${widget.price}",
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    CheckOutContainer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TitleText(
                        text: 'select_Payment_Method'.tr,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                    });
                                  }),
                              TitleText(text: 'cash_on_delivery'.tr),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                    });
                                  }),
                              TitleText(text: 'online_payment'.tr),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: TextButton(
                        onPressed: () async {
                          if (_value == 2) {
                            await makePayment("54");
                          } else if (_value == 1) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context),
                            );
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryClr),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          width: MediaQuery.of(context).size.width * .8,
                          child: TitleText(
                            text: 'place_order'.tr,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    /*     TextButton(
                child: const Text('Make Payment'),
                onPressed: ()async{
                 // await makePayment();
                },
              ),*/
                  ],
                ),
              ),
            ),
    );
  }

  Container CheckOutContainer() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEDECF2)),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Users")
              .doc(user!.uid)
              .collection("checkOut")
              .doc(user!.uid)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text("ERROR");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> checkOut = snapshot.data.data();
              CheckOutMap = checkOut["checkOut"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: 'contact'.tr,
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: checkOut["checkOut"]["phoneNumber"] ??
                                "".toString(),
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TitleText(
                    text: 'ship_to'.tr,
                    fontWeight: FontWeight.normal,
                  ),
                  TitleText(
                    text: checkOut["checkOut"]["address"] ?? "",
                    fontWeight: FontWeight.normal,
                  ),
                  Row(
                    children: [
                      TitleText(
                        text: checkOut["checkOut"]["city"] + ", " ?? "",
                        fontWeight: FontWeight.normal,
                      ),
                      TitleText(
                        text: checkOut["checkOut"]["country "] ?? "",
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutScreen(
                                      total: widget.price,
                                      cartItemsList: widget.cartItems,
                                    )));
                      },
                      child: TitleText(
                        text: 'click_to_change_delivery_information'.tr,
                        color: kPrimaryClr,
                      ))
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Owais'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    List cartItems = await getData();
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .collection('cart')
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        }).then((value) {
          print("Document deleted");
          String orderNumber = getOrderNumber();
          String currentTime = getCurrentDate();
          FirebaseFirestore.instance
              .collection("Orders")
              .doc(DateTime.now().toString())
              .set({
            "OrderNumber": orderNumber,
            "OrderList": cartItems,
            "CheckoutDetails": CheckOutMap,
            "TotalPrice": widget.price,
            "Client Email": user!.email,
            "ClientUid": user!.uid,
            "readorder": "false",
            "Time": currentTime,
            "PaymentMethod": "Online payment",
            "phoneNumberForRider": phoneNumberForRider,
            "MessageForRider": messageForRider
          });

          FirebaseFirestore.instance
              .collection("Users")
              .doc(user?.uid)
              .collection("OrderHistory")
              .doc(DateTime.now().toString())
              .set({
            "OrderNumber": orderNumber,
            "OrderList": cartItems,
            "read": "false",
            "TotalPrice": widget.price,
            "Time": currentTime,
            "PaymentMethod": "Online payment",
          }).then((value) {
            sendNotificationstoAllAdmins(orderNumber, widget.price.toString());
          });

          setState(() {
            isLoading = true;
          });

          Navigator.pop(context);
        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text('payment_successful'.tr),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.63,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -15.0,
              top: -15.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    size: 18,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /*Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color:Colors.yellow.withOpacity(0.2),
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
                                )
                            ),
                            child: Center(child: Text("Contact Me", style:TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "Helvetica"))),
                          ),*/
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TitleText(
                        text: 'cash_on_delivery'.tr,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: newPhoneNumber,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDECF2),
                            hintText: 'enter_phone_number'.tr),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_phone'.tr;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                          print(value);
                          phoneNumberForRider = value!;
                        },
                        //autofocus: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        controller: newMessage,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDECF2),
                            hintText: 'enter_message_for_rider'.tr),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter_message_for_rider'.tr;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                          messageForRider = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TitleText(
                        text:
                            'change_may_not_be_available_please_have_the_exact_amount'
                                .tr,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                        onPressed: () async {
                          final isvalid = _formKey.currentState!.validate();
                          if (isvalid) {
                            _formKey.currentState!.save();
                            List cartItems = await getData();
                            print("CART LIST");
                            print(cartItems);
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(user?.uid)
                                .collection('cart')
                                .get()
                                .then((snapshot) {
                              for (DocumentSnapshot ds in snapshot.docs) {
                                ds.reference.delete();
                              }
                            }).then((value) {
                              print("Document deleted");
                              String orderNumber = getOrderNumber();
                              String currentTime = getCurrentDate();
                              FirebaseFirestore.instance
                                  .collection("Orders")
                                  .doc(DateTime.now().toString())
                                  .set({
                                "OrderNumber": orderNumber,
                                "OrderList": cartItems,
                                "CheckoutDetails": CheckOutMap,
                                "TotalPrice": widget.price,
                                "Client Email": user!.email,
                                "ClientUid": user!.uid,
                                "Time": currentTime,
                                "readorder": "false",
                                "PaymentMethod": "Cash on delivery",
                                "phoneNumberForRider": phoneNumberForRider,
                                "MessageForRider": messageForRider
                              });
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(user?.uid)
                                  .collection("OrderHistory")
                                  .doc(orderNumber)
                                  .set({
                                "OrderNumber": orderNumber,
                                "OrderList": cartItems,
                                "read": "false",
                                "TotalPrice": widget.price,
                                "Time": currentTime,
                                "status": "Pending",
                                "PaymentMethod": "Cash on delivery",
                              }).then((value) {
                                sendNotificationstoAllAdmins(
                                    orderNumber, widget.price.toString());
                              });
                              setState(() {
                                isLoading = true;
                              });

                              Navigator.pop(context);
                            });
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryClr),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          width: MediaQuery.of(context).size.width * .8,
                          child: TitleText(
                            text: 'confirm_order'.tr,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//looping calling of notification function

void sendNotificationstoAllAdmins(String orderid, String orderamount) async {
  SendPushNotification notificationclass = SendPushNotification();
  String title = 'New Message';
  String body = "New Order Request";
  QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('admin_details').get();
  List admintokenlist = usersSnapshot.docs.toList();
  for (var element in admintokenlist) {
    String token = element["token"].toString();
    notificationclass.sendOrderPushNotificationsToAdmins(
        body, title, token, orderid, orderamount);
  }
}
