import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/TitleText.dart';


import '../Services/auth_service.dart';
import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/utilities.dart';
import '../loginProcess/change_password_screen.dart';
import '../loginProcess/edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final authServices = AuthServices();
    final style = ScreenStyles();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(text:'settings'.tr,fontSize: 18,fontWeight: FontWeight.w500,),


        elevation: 1,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          child: style.backIconButton(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
              left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SettingOps(
                      title: 'edit_profile'.tr,
                      icon: Icons.drive_file_rename_outline,
                      function: () {
                        debugPrint("Button press");
                        Utilities.nextScreen(
                            context, const EditProfileScreen());
                      }),
                  SettingOps(
                      title: 'change_password'.tr,
                      icon: Icons.password_outlined,
                      function: () {
                        Utilities.nextScreen(
                            context, const ChangePasswordScreen());
                      }),
                  SettingOps(
                      title: 'logout'.tr,
                      icon: Icons.logout_sharp,
                      function: () {
                        debugPrint("Button press");
                        showGeneralDialog(
                            context: context,
                            barrierLabel: "Barrier",
                            barrierDismissible: true,
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionDuration:
                            const Duration(milliseconds: 700),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                       Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'alert'.tr,
                                          style: TextStyle(
                                            color: AppColors.kPrimaryClr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                       Padding(
                                        padding: EdgeInsets.only(top: 10.0),
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
                                                    color:
                                                    AppColors.kPrimaryClr,
                                                    border: Border.all(
                                                      color:
                                                      AppColors.kPrimaryClr,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(
                                                            4))),
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
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: AppColors.kGreyClr,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(
                                                            4))),
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
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingOps extends StatelessWidget {
  final dynamic function;
  final dynamic icon;
  final String title;

  const SettingOps(
      {Key? key,
        required this.function,
        required this.icon,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.kGreyClr),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.kPrimaryClr,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'Helvetica LTStd',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
