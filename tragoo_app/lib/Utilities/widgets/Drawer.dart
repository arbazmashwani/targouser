import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/screens/ContactUs_Screen.dart';
import 'package:tragoo_app/screens/settings.dart';

import 'package:tragoo_app/services/auth_service.dart';
import '../../screens/language_Screen.dart';
import '../../screens/order_history_screen.dart';
import '../../screens/user suggestion.dart';
import '../../services/current_user.dart';
import '../../services/database_services.dart';
import '../constants/TitleText.dart';
import '../constants/app_colors.dart';
import '../constants/ui_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String url = '';
  String currentUserName = "";

  getImage() async {
    var imageName = CurrentUserDetails.getUID();
    String url1 = await FirebaseStorage.instance
        .ref()
        .child('profile_photo/$imageName')
        .getDownloadURL();
    setState(() {
      url = url1;
    });
    print('_______________________________');
    print(url);
  }
  getUserDetails() async {
    print("inFUnction_______");
    var userDetails = await DatabaseServices.getCollection(collection: "user_details");
    for (var queryDocumentSnapshot in userDetails.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (CurrentUserDetails.getEmail() == data['email']) {
        setState(() {
          currentUserName = data['name'];
        });
      }
    }
    print(currentUserName);
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getImage();

  }
  @override
  Widget build(BuildContext context) {
    final loginStyles = ScreenStyles();
    final authServices = AuthServices();
    return
      Scaffold(
        body: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(

                color: kPrimaryClr,
                /*image: DecorationImage(
                  image: url != ''
                      ? NetworkImage(url)
                      : const AssetImage(
                    'assets/images/img.png',
                  ) as ImageProvider,
                  fit: BoxFit.cover,
                )*/

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(

            backgroundImage:
                    url != ''
                        ? NetworkImage(url)
                        : const AssetImage(
                      'assets/images/img.png',
                    ) as ImageProvider,


                  radius: 35,
                  backgroundColor: Colors.white,
                ),
                Text(
                  currentUserName == '' ? 'Guest' : currentUserName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.only(bottom: 5.0, top: 1),
                  child: Text(
                    CurrentUserDetails.getEmail() ?? 'You are using wiskeyb as a guest:-)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: 'home'.tr,color: kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contacts,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: 'contact_Us'.tr,color: kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Get.to(const ContactUs_Screen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: "Settings",color: kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Get.to(const SettingsScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: "language".tr,color:kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Get.to(const LanguageSelection());

            },
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark_border_sharp,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: 'My Orders'.tr,color: kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Get.to(const OrderHistoryScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: AppColors.kPrimaryClr,
            ),
            title: TitleText(text: 'suggestions'.tr,color: kPrimaryClr,fontWeight: FontWeight.w400,),
            onTap: () {
              Get.to(const Suggestions());
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColors.kRedClr,
            ),
            title: TitleText(text: 'logout'.tr,color: Colors.red,fontWeight: FontWeight.w400,),
            onTap: () async {
              showGeneralDialog(
                  context: context,
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0))),
                      contentPadding: const EdgeInsets.only(
                          top: 20.0, left: 15.0, right: 15.0),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'logout'.tr,
                                style: TextStyle(
                                  color: AppColors.kPrimaryClr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'are_you_sure_you_want_to_logout?'.tr,
                                style: TextStyle(
                                  color: AppColors.kPrimaryClr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      authServices.signOut(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 75.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.kPrimaryClr,
                                          border: Border.all(
                                            color: AppColors.kPrimaryClr,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(4))),
                                      child:  Text(
                                        'logout'.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 75.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: AppColors.kGreyClr,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Text(
                                        'cancel'.tr,
                                        style: TextStyle(
                                          color: AppColors.kRedClr,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
    ),
      );
  }
}
