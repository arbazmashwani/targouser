import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/constants/ui_view.dart';


class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onBoardStyles = ScreenStyles();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          onBoardStyles.customButton(
            btnFunction: ()  {
              Get.updateLocale(const Locale('en','uk'));

            },
            btnText: "English",
            context: context,
          ),

          onBoardStyles.customButton(
            btnFunction: ()  {
              Get.updateLocale(const Locale('en','uk'));

            },
            btnText: "Spanish",
            context: context,
          ),
        ],
      ),
    );
  }
}
