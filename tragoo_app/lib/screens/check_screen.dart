import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';
import 'package:tragoo_app/screens/Main.dart';

import '../Utilities/constants/TitleText.dart';


class AgeLimitScreen extends StatefulWidget {
  const AgeLimitScreen({Key? key}) : super(key: key);

  @override
  State<AgeLimitScreen> createState() => _AgeLimitScreenState();
}

class _AgeLimitScreenState extends State<AgeLimitScreen> {
  bool AgeBool = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Image.asset('images/age21.png'),
            ),
            Row(
              children: [
                Checkbox(value: AgeBool, onChanged: (value){
                  if(AgeBool)
                    {
                      AgeBool =false;
                    }
                  else {
                    AgeBool = true;
                  }
                  setState(() {

                  });
                }),
                Expanded(
                  child: Text("i_agree_that_my_age_is_above_21_to".tr
                      ,maxLines:3 ,style: GoogleFonts.mulish(
                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                )
              ],
            )
          ],
        )
        ),
      ),
     bottomNavigationBar: Container(
       height: 150 ,

       child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: TextButton(
            onPressed: () {
              if(AgeBool)
                {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => MyNewHomePage()));
                }
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                backgroundColor: MaterialStateProperty.all(kPrimaryClr),

            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4),
              width: MediaQuery.of(context).size.width  * .8,
              child: TitleText(
                text: 'get_started'.tr,
                color:Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
     ),
    );
  }
}
