import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/constants/variables.dart';
import '../services/auth_service.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final forgotPassAuthServices = AuthServices();


  @override
  Widget build(BuildContext context) {
    final forgotPassStyles = ScreenStyles();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading:  Padding(
            padding:const EdgeInsets.only(left: 15.0),
            child: forgotPassStyles.backIconButton(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      "images/trago.png",
                      height: 120,
                      width: 120,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 35.0, bottom: 5.0),
                      child: forgotPassStyles.screenTitle("forgot_password".tr),
                    ),
                     Text(
                      "don't_worry_it_happenes_please_enter_the_address_associated_with_your_account".tr,
                      style: const TextStyle(fontSize: 15,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: forgotPassStyles.customTextField(
                        hint: "email_id".tr,
                        obscure: false,
                        txtController: _emailController,
                        icon: Icons.alternate_email_outlined,
                        keyboard: TextInputType.emailAddress,
                        validate: (val) {
                          String pattern = Variables.emailPattern;
                          RegExp regExp = RegExp(pattern);
                          if (val!.isEmpty) {
                            return "email_is_required".tr;
                          } else if (!regExp.hasMatch(val)) {
                            return "enter_correct_email".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    forgotPassStyles.customButton(
                      btnFunction: () async {
                        final isFilled = _formKey.currentState?.validate();
                        if (!isFilled!) {
                          return null;
                        } else {
                          debugPrint("Submit Tab forgotPassAuthServices");
                          await forgotPassAuthServices.resetPassword(_emailController.text.trim(), context);

                        }
                      },
                      btnText: "submit".tr,
                      context: context,
                    ),
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
