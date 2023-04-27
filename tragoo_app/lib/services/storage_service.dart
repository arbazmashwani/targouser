import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<void> uploadImage(
      {required String imgPath, required String imgName}) async {
    File img = File(imgPath);
    try {
      await storage.ref('profile_photo/$imgName').putFile(img);
    } catch (e) {
      print(e);
    }
  }
}
