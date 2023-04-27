import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tragoo_app/Utilities/constants/app_colors.dart';

import '../Utilities/constants/TitleText.dart';
import 'Main.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({Key? key}) : super(key: key);
  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  TextEditingController customerName = TextEditingController();
  TextEditingController cusContact = TextEditingController();
  TextEditingController Suggesstions = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String Name = "";
  String Email = "";
  String Suggestion = "";
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                SizedBox(height: 10,),
                _submitForm()

              ],
            ),
          ),
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
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    text:  "Cant_find_what_you_are_looking_for".tr,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  TitleText(
                    text:  'please_fill_out_this_suggestion_form'.tr,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),

          ],
        ));
  }
  Widget _submitForm() {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: customerName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color(0xFFEDECF2),
                    hintText: 'your_name'.tr
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_name'.tr;
                  }
                },
                onSaved: (value) {
                  Name = value!;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_the_email_address'.tr;
                  }
                },
                onSaved: (value) {
                  Email = value!;
                },
                controller: cusContact,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color(0xFFEDECF2),
                    hintText: 'your_email_address'.tr
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'suggestion_message'.tr;
                  }
                },
                onSaved: (value) {
                  Suggestion = value!;
                },
                maxLines: 20,
                controller: Suggesstions,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color(0xFFEDECF2),
                    hintText: 'please_write_some_suggestion'.tr
                ),
              ),
              SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  final isvalid = formKey.currentState!.validate();
                  if (isvalid) {
                    formKey.currentState!.save();

                    FirebaseFirestore.instance.collection("Suggestion").doc(DateTime.now().toString()).set(
                        {
                          "Name": Name,
                          "Email": Email,
                          "Message": Suggestion
                        }
                    ).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>   MyNewHomePage()));
                    });

                  }
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .8,
                  child: TitleText(
                    text: 'submit_form'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
