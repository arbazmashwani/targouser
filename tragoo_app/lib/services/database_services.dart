import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices{

  FirebaseFirestore fireStoreInstance=FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

   Future<void> addNewQuestion(String quizID,dynamic quizData,) async{
    await fireStoreInstance.collection("questions").doc(quizID).set(quizData).catchError((e){
      debugPrint(e);
    });


   }

  static getCollection({@required collection}) async{
    CollectionReference<Map<String, dynamic>> docRef=  FirebaseFirestore.instance.collection(collection);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await docRef.get();
    return querySnapshot;

  }



  static updateData(String key,dynamic value){
    var collection = FirebaseFirestore.instance.collection('user_details');
    collection.doc(CurrentUserDetails.getUID())
        .update({key : value});
  }

  /*updateQuantity(String key,dynamic value){
    FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('cart').doc('Liquor').update({key : value});

  }*/

  Future<String> deleteCartItem(String docID) async
  {
  await FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('cart').doc(docID).delete();
  return "Item Deleted From Cart";
  }

  Future<String> UpdateCartItemQuantity(String docID ,int quantity) async
  {
    await FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('cart').doc(docID).update(
        {
          'Quantity': quantity
        });
    return "Quantity Updated to Cart";
  }

}
