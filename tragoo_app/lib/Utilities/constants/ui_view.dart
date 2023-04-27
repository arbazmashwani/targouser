import 'package:flutter/material.dart';
import 'app_colors.dart';

class ScreenStyles {
  ///screenTitle
  screenTitle(String txt) {
    return Text(
      txt,
      style: TextStyle(
          color: AppColors.kPrimaryClr,
          fontWeight: FontWeight.w600,
          fontSize: 35.0,
        fontFamily: 'Helvetica LTStd',
      ),
      textAlign: TextAlign.left,
    );
  }

  ///customTextField
  customTextField(
      {required IconData icon,
      txtController,
      validate,
      keyboard,
      obscure,
      postfix,
      hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              icon,
              color: AppColors.kGreyClr,
              size: 25.0,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: txtController,
              validator: validate,
              keyboardType: keyboard,
              obscureText: obscure,
              cursorColor: AppColors.kPrimaryClr,
              decoration: InputDecoration(
                focusedBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.kPrimaryClr,
                  ),
                ),
                suffixIcon: postfix,
                hintText: hint,
                hintStyle: TextStyle(color: AppColors.kGreyClr, fontSize: 15.0,fontFamily: 'Helvetica LTStd',),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    0.01,
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey.shade50,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  customButton(
      {@required btnFunction,
      required BuildContext context,
      required String btnText}) {
    return InkWell(
      onTap: btnFunction,
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        width: MediaQuery.of(context).size.width * 1,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.kPrimaryClr,
            border: Border.all(
              color: AppColors.kPrimaryClr,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Helvetica LTStd',
          ),
        ),
      ),
    );
  }

  backIconButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: const EdgeInsets.only(top: 15.0),
        alignment: Alignment.topLeft,
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.kGreyBtnClr,
          size: 25,
        ),
      ),
    );
  }

  ///TextButton
  customTextButton({@required btnFunction, required String btnText}) {
    return TextButton(
        onPressed: btnFunction,
        child: Text(
          btnText,
          style:  TextStyle(color: AppColors.kPrimaryClr),
        ));
  }





}



