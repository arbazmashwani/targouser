import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import '../Utilities/constants/TitleText.dart';
import '../screens/Main.dart';
import 'login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class SplashScreen extends StatelessWidget {

   SplashScreen({Key? key}) : super(key: key);


  checkLoginState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
         LoginScreen();
      } else {
        MyNewHomePage();
      }
    });
  }
  User? user = FirebaseAuth.instance.currentUser;
   @override
  /* void initState() {
     super.initState();
     Timer(const Duration(seconds: 2), () => checkLoginState());
   }*/
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
          nextScreen:FirebaseAuth.instance.currentUser == null ? LoginScreen(): MyNewHomePage()  ,
          splashIconSize: 400,
          duration: 4000,
          backgroundColor: Color(0XFF82EEFD),
          splashTransition: SplashTransition.slideTransition ,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          splash: Column(
            children: [
              Image.asset("images/trago.png",height: 300,width: 300,),
               SizedBox(height: 50,),
               TitleText(
                text: "why_limit_happy_to_an_hour".tr ,fontSize:25,fontWeight: FontWeight.bold,color: Colors.blue,),
            ],
          ),
       );
  }
}