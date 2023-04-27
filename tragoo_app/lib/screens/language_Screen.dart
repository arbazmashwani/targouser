
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utilities/constants/TitleText.dart';
import '../Utilities/constants/app_colors.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({Key? key}) : super(key: key);
  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(


                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color:
                    Colors.transparent ,

                  ),
                  height: 50,
                  width: 50,

                  child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      )),


                ),
              ),
            ),
            _title(),
            // TitleText(text: "Your suggestions are welcome",),
            SizedBox(height: MediaQuery.of(context).size.height/3),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextButton(
                onPressed: () {
                  Get.updateLocale(Locale('en', 'uk'));
                  Get.back();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(kPrimaryClr),
                ),

                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  width: MediaQuery.of(context).size.width *0.8,
                  child: TitleText(
                    text: 'english'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextButton(
                onPressed: () {
                  Get.updateLocale(
                      const Locale('spa', 'spanish'));
                  Get.back();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(kPrimaryClr),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  width: MediaQuery.of(context).size.width *0.8,
                  child: TitleText(
                    text: 'spanish'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
        margin:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text:  'select_language'.tr,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),

              ],
            ),

          ],
        ));
  }
}
