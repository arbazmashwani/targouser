import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../services/current_user.dart';
import '../services/storage_service.dart';
import 'Main.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  dynamic image;
  final StorageService storage = StorageService();
  dynamic pickedImage;
  final _auth = FirebaseAuth.instance;

   void getCurrentUser() async
   {
     try{
       final user =_auth.currentUser!;
       print(user.email);
     }
     catch(e)
     {
       print(e);
     }
   }
  Future getImage() async {
    pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

//function for image url save to database
  void savedToDatabase(image) {
    var imgPath = image?.path;
    storage.uploadImage(
        imgPath: imgPath!, imgName: CurrentUserDetails.getUID());
    image == null ? 'Choose profile image' : Get.off(const MyNewHomePage());
  }
@override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    final uploadImageStyles = ScreenStyles();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.kWhiteClr,
        actions: [
          Container(
            alignment: Alignment.topRight,
            child: uploadImageStyles.customTextButton(
              btnFunction: () {
                Get.off(const MyNewHomePage());
              },
              btnText: "skip".tr,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                    'Upload your profile picture so that your your friends can recognise you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.kBlackClr,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: image != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 60.0, top: 40.0),
                        child: CircleAvatar(
                          radius: 90.0,
                          backgroundImage: FileImage(
                            image!,
                          ),
                        ),
                      )
                    : Container(
                        height: 140,
                        width: 140,
                        margin: const EdgeInsets.only(bottom: 70.0, top: 40.0),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Image.asset(
                          'images/img.png',
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              uploadImageStyles.customButton(
                btnFunction: () {
                  savedToDatabase(pickedImage!);
                },
                btnText: "upload".tr,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
