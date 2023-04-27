

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class dataBaseManager {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference productRef = FirebaseFirestore.instance.collection(
      'products_details');

  Future getUserList() async {
    List itemList = [];
    try {
      await productRef.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          itemList.add(element);
        });
      });
      return itemList;
    }
    catch (e) {
      print(e);
    }
  }


}
