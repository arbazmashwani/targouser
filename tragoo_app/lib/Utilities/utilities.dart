import 'package:flutter/material.dart';

import 'constants/app_colors.dart';



class Utilities{

  static   void onLoading(BuildContext context,String msg) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children:  <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(
            width: 30,
          ),
           Expanded(child: Text(msg)),
        ],
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alertDialog,
    );
  }

  static void showToast(BuildContext context, message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.black87,
      margin: EdgeInsets.only(
           bottom: MediaQuery.of(context).size.height*0.05,
          right: 20,
          left: 20),
        duration: const Duration(milliseconds: 500)
    )
    );
  }


  static nextScreen(BuildContext context,screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

   alertBox(BuildContext context,function) {
    return  showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius:  BorderRadius.all( Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Alert",
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
                      "Are you sure you want to logout?",
                      style: TextStyle(
                        color: AppColors.kPrimaryClr,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //homeAuthServices.signOut(context);

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
                                const BorderRadius.all(Radius.circular(4))),
                            child: const Text(
                              "Logout",
                              style:  TextStyle(
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
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.kGreyClr,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                            child: const Text(
                              "Cancel",
                              style:  TextStyle(
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
          );}
    );
  }

}