import 'package:firebase_auth/firebase_auth.dart';


class CurrentUserDetails {
  static final  FirebaseAuth authInstance = FirebaseAuth.instance;

  static getEmail(){
    String? userEmail = authInstance.currentUser?.email;
    return userEmail;
  }

  static getUID(){
    String? userUID = authInstance.currentUser?.uid;
    return userUID;
  }


}