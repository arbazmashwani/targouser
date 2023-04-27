import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tragoo_app/screens/upload_profile.dart';
import '../Utilities/constants/TitleText.dart';
import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/constants/variables.dart';
import '../Utilities/utilities.dart';
import '../screens/check_screen.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../loginProcess/login.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _numberController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();
  final signupAuthServices = AuthServices();

  bool inVisiblePass = true;
  bool inVisibleConfirm = true;

  final StorageService storage = StorageService();
  final _firestor =  FirebaseFirestore.instance;
  void _togglePasswordView() {
    setState(() {
      inVisiblePass = !inVisiblePass;
    });
  }

  _signupFunction() {
    final gName = _fullNameController.text.toString().trim();
    final gEmail = _emailController.text.toString().trim();
    final gPass = _passController.text.toString().trim();
    final gNumber = _numberController.text.toString().trim();
    final gBirthDate = _birthDateController.text.toString().trim();
    print('=======================================');
    print(gName);
    print(gEmail);
    try{
      signupAuthServices.signUpWithEmailAndPassword(gName, gEmail, gPass, gNumber, gBirthDate, context)
          .then((value) {
        if (value != null) {
          Utilities.nextScreen(context, const UploadImage());
        }

      });
      _firestor.collection('user_details').add(
          {
            'email': gEmail,
            'name': gName
          }
      );
    }
    catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    final signupStyles = ScreenStyles();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
              child: Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    Image.asset(
                      "images/trago.png",
                      height: 120,
                      width: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TitleText(text: 'SIGNUP',fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue.shade900,)),
                    ),
                    signupStyles.customTextField(
                      hint: "full_name".tr,
                      obscure: false,
                      txtController: _fullNameController,
                      icon: Icons.account_circle_outlined,
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "full_name_is_required".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    signupStyles.customTextField(
                      hint: "phone-number".tr,
                      obscure: false,
                      txtController: _numberController,
                      icon: Icons.call,
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "phone-number_is_required".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    signupStyles.customTextField(
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
                    signupStyles.customTextField(
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
                        }
                        if (val.length < 6) {
                          return "password_should_be_at_least_6_characters".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                  /*  Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: SizedBox(
                        width: 80.0,
                        child: TextFormField(
                          readOnly: true,
                          controller: _birthDateController,
                          decoration: InputDecoration(
                            labelText: "date_of_birth".tr,
                          ),
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(2025),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                _birthDateController.text =
                                    DateFormat('yyyy-MM-dd')
                                        .format(selectedDate);
                              }
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter date.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),*/
                    SizedBox(height: 20,),
                    signupStyles.customButton(
                      btnFunction: () {
                        debugPrint("Sign Up Tab");
                        final isFilled =
                            _registerFormKey.currentState?.validate();
                        if (!isFilled!) {
                          return null;
                        } else {
                          _signupFunction();
                        }
                      },
                      btnText: "continue".tr,
                      context: context,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "joined_us_before".tr,
                        ),
                        signupStyles.customTextButton(
                          btnFunction: () {
                            Utilities.nextScreen(context, const AgeLimitScreen());
                          },
                          btnText: "login".tr,
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
