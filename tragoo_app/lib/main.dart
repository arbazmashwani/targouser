import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tragoo_app/loginProcess/splash.dart';


import 'Utilities/constants/internationalization.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51JeXmMKqM4h5Xm0EAbcGDizMLXyJrSHVtTv1kgMcuxXmP5sv9KEpIbg4vHW3ZR7RtpNhWn1heBkRcxYfKAZJw3G4009zWiSsfF';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return  GetMaterialApp(
       theme: ThemeData(

       ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      translations: LocaleStrings(),
      home:SplashScreen(),

    );
  }
}

