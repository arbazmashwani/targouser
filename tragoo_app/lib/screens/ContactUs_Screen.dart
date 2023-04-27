import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utilities/constants/TitleText.dart';
import '../Utilities/constants/app_colors.dart';

class ContactUs_Screen extends StatefulWidget {
  const ContactUs_Screen({Key? key}) : super(key: key);

  @override
  State<ContactUs_Screen> createState() => _ContactUs_ScreenState();
}

class _ContactUs_ScreenState extends State<ContactUs_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color:
                      Colors.transparent,
                    ),
                    height: 50,
                    width:  50,
                    child: const Center(
                          child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                ),
              ),
              _title(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 5  horizontally
                              5.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ]
                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          _launchWhatsApp();
                        }, icon: const Icon(Icons.call, size: 50, color: Colors
                            .green,),),
                        const TitleText(text: "What's App")
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 5  horizontally
                              5.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ]

                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( 'please_fill_the_form'.tr
                              )));
                        },
                          icon: const Icon(
                            Icons.email_outlined, size: 50, color: Colors
                              .red,),),
                          TitleText(text: 'send_email'.tr)
                      ],
                    ),
                  )
                ],

              ),
              FormView()
            ],
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    String phoneNumber = "92332239165"; // Replace with your phone number
    String message = "Hello!"; // Replace with your message
    String whatsappUrl = "https://wa.me/16128011732";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }


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
                    text: 'get_In_Touch'.tr,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  TitleText(
                    text:  'Contact_us_for_any_query'.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),

                ],
              ),
            ),

          ],
        ));
  }

class FormView extends StatelessWidget {
   FormView({Key? key}) : super(key: key);
  TextEditingController subjectCont = TextEditingController();
  TextEditingController NameCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String subject = "";
  String Name = "";
  String body= "";
  @override
  _launchEmail(String email1 , String subject1 , String body1) async {

    final String email = Uri.encodeComponent(email1);
    String subject = Uri.encodeComponent(subject1);
    String body = Uri.encodeComponent(body1);
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    //String emailURL = "mailto:bushraumer524@gmail.com";
    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    } else {
      throw 'Could not launch $email ';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: NameCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEDECF2),
                    hintText: 'your_name'.tr
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_name'.tr;
                  }
                  return null;
                },
                onSaved: (value) {
                 Name = value!;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_the_Subject'.tr;
                  }
                  return null;
                },
                onSaved: (value) {
                  subject = value!;
                },
                controller: subjectCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEDECF2),
                    hintText: 'subject'.tr
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'write_message'.tr;
                  }
                  return null;
                },
                onSaved: (value) {
                  body = value!;
                },
                maxLines: 13,
                controller: bodyCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEDECF2),
                    hintText: 'type_message'.tr
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  final isvalid = formKey.currentState!.validate();
                  if (isvalid) {
                    formKey.currentState!.save();
                    _launchEmail("fzolutions0@gmail.com",subject,Name+body);
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
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .8,
                  child: TitleText(
                    text: 'send_email'.tr,
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
