import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../Utilities/utilities.dart';
import '../screens/Main.dart';
import '../services/database_services.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool inVisiblePass = true;
  bool inVisibleNewPass = true;
  bool inVisibleConfirmPass = true;
  Map<String, dynamic> data = {};

  updatePassword() async {
    print("Innnn    Password can't be changed" );

    var userDetails =
        await DatabaseServices.getCollection(collection: "user_details");
    for (var queryDocumentSnapshot in userDetails.docs) {
      print("Innnn    Password can't be changed" );

      data = queryDocumentSnapshot.data();
      if (_currentPasswordController.text == data['password']) {
        User? user = FirebaseAuth.instance.currentUser!;
        user.updatePassword(_newPasswordController.text).then((_) {
          DatabaseServices.updateData('password', _newPasswordController.text);
          Utilities.nextScreen(context, const MyNewHomePage());
          Utilities.showToast(context, "Password Changed");
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
        });
      }
    }

   
  }

  void _togglePasswordView() {
    setState(() {
      inVisiblePass = !inVisiblePass;
    });
  }

  void _toggleNewPasswordView() {
    setState(() {
      inVisibleNewPass = !inVisibleNewPass;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      inVisibleConfirmPass = !inVisibleConfirmPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    final editPasswordStyles = ScreenStyles();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Edit Password",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Helvetica LTStd',
              ),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: editPasswordStyles.backIconButton(context),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    editPasswordStyles.customTextField(
                      hint: "Current  password",
                      obscure: inVisiblePass,
                      txtController: _currentPasswordController,
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
                          return "Current password is required!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    editPasswordStyles.customTextField(
                      hint: "New password",
                      obscure: inVisibleNewPass,
                      txtController: _newPasswordController,
                      icon: Icons.lock_outline_rounded,
                      postfix: IconButton(
                        color: AppColors.kGreyClr,
                        icon: Icon(
                          inVisibleNewPass == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: _toggleNewPasswordView,
                      ),
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "New password is required!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    editPasswordStyles.customTextField(
                      hint: "Confirm new password",
                      obscure: inVisibleConfirmPass,
                      txtController: _confirmPasswordController,
                      icon: Icons.lock_outline_rounded,
                      postfix: IconButton(
                        color: AppColors.kGreyClr,
                        icon: Icon(
                          inVisibleConfirmPass == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: _toggleConfirmPasswordView,
                      ),
                      keyboard: TextInputType.text,
                      validate: (val) {
                        if (val.length == 0) {
                          return "New password is required!";
                        }
                        if (_confirmPasswordController.text !=
                            _newPasswordController.text) {
                          return "Not match!";
                        } else {
                          null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: editPasswordStyles.customButton(
                        btnFunction: () async {
                          debugPrint("Change Tab");
                          final isFilled = _formKey.currentState?.validate();
                          if (!isFilled!) {
                            return null;
                          }

                         else {
                            updatePassword();
                          }
                        },
                        btnText: "Change",
                        context: context,
                      ),
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
