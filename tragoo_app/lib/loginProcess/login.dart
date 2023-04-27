import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tragoo_app/loginProcess/signup.dart';



import '../Utilities/constants/TitleText.dart';
import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/constants/variables.dart';
import '../Utilities/utilities.dart';
import '../screens/Main.dart';
import '../services/auth_service.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool inVisiblePass = true;
  final loginAuthServices = AuthServices();


  _loginFunction()async{
    final email = _emailController.text.toString().trim();
    final pass = _passController.text.toString().trim();
    User? user = await loginAuthServices.loginWithEmailAndPassword(email, pass, context);
    if (user != null) {
      Get.off( const MyNewHomePage());
    }
  }

  void _togglePasswordView() {
    setState(() {
      inVisiblePass = !inVisiblePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginStyles = ScreenStyles();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                              height: 150,
                              color: AppColors.kPrimaryClr,
                              child: Column(
                                children: [
                                  loginStyles.customButton(
                                    btnFunction: () {
                                      Get.updateLocale(Locale('en', 'uk'));
                                      Get.back();
                                    },
                                    btnText: "english".tr,
                                    context: context,
                                  ),
                                  loginStyles.customButton(
                                    btnFunction: () {
                                      Get.updateLocale(
                                          const Locale('spa', 'spanish'));
                                      Get.back();
                                    },
                                    btnText: "spanish".tr,
                                    context: context,
                                  ),
                                ],
                              )),
                          barrierColor: Colors.red[50],
                          isDismissible: false,
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 90.0,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.kPrimaryClr,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child:  Text(
                            "language".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.kPrimaryClr,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      "images/trago.png",
                      height: 120,
                      width: 120,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8
                      ),
                      alignment: Alignment.centerLeft,
                      child: TitleText(text: 'LOGIN',fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue.shade900,),
                    ),
                    loginStyles.customTextField(
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
                    loginStyles.customTextField(
                      hint: "password".tr,
                      obscure: inVisiblePass,
                      txtController: _passController,
                      icon: Icons.lock_outline_rounded,
                      postfix: IconButton(
                        color: AppColors.kGreyClr,
                        icon: Icon(
                          inVisiblePass == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: _togglePasswordView,
                      ),
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "password_is_required".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: loginStyles.customTextButton(
                        btnFunction: () {
                          Utilities.nextScreen(
                              context, const ForgotPasswordScreen());
                        },
                        btnText: "forgot_password".tr,

                      ),
                    ),
                    loginStyles.customButton(
                      btnFunction: () async {
                        final isFilled = _formKey.currentState?.validate();
                        if (!isFilled!) {
                          return null;
                        } else {
                           _loginFunction();
                        }
                      },
                      btnText: "login".tr,
                      context: context,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'new_to_trago'.tr,
                        ),
                        loginStyles.customTextButton(
                          btnFunction: () {
                            Utilities.nextScreen(context, const SignUpScreen());
                          },
                          btnText: "register".tr,
                        ),
                      ],
                    )
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
