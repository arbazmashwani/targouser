import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/utilities.dart';
import '../loginProcess/login.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future signUpWithEmailAndPassword(String name, String email, String pass,
      String number, birthDate, BuildContext context) async {
    print('++++++++++++++++++++++');
    print(user?.email);
    Utilities.onLoading(context, "Registering.. Please Wait !");
    try {
      var result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((signedInUser) => {
                FirebaseFirestore.instance
                    .collection('user_details')
                    .doc(signedInUser.user?.uid)
                    .set({
                  'name': name,
                  'email': email,
                  'phone_number': number,
                  'password': pass,
                  'date_of_birth': birthDate,
                }).then((signedInUser) => print('success'))
              });
      return result;
    } catch (e) {
      print(e);
      Utilities.onLoading(context, "$e");

      return null;
    }
  }

  Future loginWithEmailAndPassword(
      String email, String pass, BuildContext context) async {
    Utilities.onLoading(context, "Login...Please Wait !");

    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      User? lUser = result.user;
      return lUser;
    } catch (e) {
      print(e);
      Utilities.onLoading(context, "$e");

      return null;
    }
  }

  Future resetPassword(String email, BuildContext context) async {
    try {
      Utilities.onLoading(context, "Reset Password Email Sent.");
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      print(e);
      return null;
    }
  }
}
