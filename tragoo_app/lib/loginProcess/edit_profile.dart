import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/utilities.dart';
import '../screens/Main.dart';
import '../services/current_user.dart';
import '../services/database_services.dart';
import '../services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? currentUserName = "";
  dynamic image;
  String url = '';
  final StorageService storage = StorageService();

  getUserDetails() async {
    var userDetails =
    await DatabaseServices.getCollection(collection: "user_details");
    for (var queryDocumentSnapshot in userDetails.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (CurrentUserDetails.getEmail() == data['email']) {
        setState(() {
          currentUserName = data['name'];
        });
      }
      _fullNameController.text = currentUserName!;
    }
  }

  pickProfileImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
    var imgPath = pickedImage?.path;
    storage.uploadImage(
        imgPath: imgPath!, imgName: CurrentUserDetails.getUID());
  }

  getImage() async {
    var imageName = CurrentUserDetails.getUID();
    String url1 = await FirebaseStorage.instance
        .ref()
        .child('profile_photo/$imageName')
        .getDownloadURL();
    setState(() {
      url = url1;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    final changeNameStyles = ScreenStyles();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Helvetica LTStd',
            ),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
            ),
            child: changeNameStyles.backIconButton(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding:
              const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                              child: GestureDetector(
                                  onTap: () {
                                    pickProfileImage();
                                  },
                                  child: image != null

                                      ? CircleAvatar(
                                      radius: 46.0,
                                      backgroundImage: NetworkImage(url==''?image.toString():url))
                                      : const CircleAvatar(
                                    radius: 46.0,
                                    backgroundImage: AssetImage(
                                      'assets/images/img.png',
                                    ),
                                  ))),
                          Positioned(
                            right: 126.0,
                            top: 75.0,
                            child: Container(
                              height: 20,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.kPrimaryClr),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    changeNameStyles.customTextField(
                      hint: "Full name",
                      obscure: false,
                      txtController: _fullNameController,
                      icon: Icons.account_circle_outlined,
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "Full name is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                        bottom: 35.0,
                      ),
                      child: changeNameStyles.customButton(
                        btnFunction: () async {
                          debugPrint("Change Tab");
                          final isFilled = _formKey.currentState?.validate();
                          if (!isFilled!) {
                            return null;
                          } else {
                            DatabaseServices.updateData(
                                'name', _fullNameController.text.toString());
                            Utilities.nextScreen(
                                context, const MyNewHomePage());
                          }
                        },
                        btnText: "Update",
                        context: context,
                      ),
                    ),
                    // Image.network(url)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
