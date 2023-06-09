// import 'dart:convert';

import 'package:JAGGPS/screens/splashscreen/splashscreen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:JAGGPS/dataservices/messagingclass.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;

  const WebViewExample({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  WebViewController? _controllers;
  bool isloading = true;
  final Messagingclass _messagingclass = Messagingclass();
  String tokens = "";
  @override
  void initState() {
    //get token function
    _messagingclass.gettoken().then((value) {
      DatabaseReference tokenTestingRefrence = FirebaseDatabase.instance.ref();
      tokenTestingRefrence.child("token").set(value);
      setState(() {
        tokens = value;
      });
    });
    //initilization of services of notification Services
    _messagingclass.initializeNotificationService(context);
    //background meeage
    _controllers = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        "appChannel",
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == "getToken") {
            _controllers!.runJavaScript('receiveToken("$tokens");');
            // ignore: avoid_print
            print('Received message from WebView: ${message.message}');
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isloading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://jaggps.com'));

    // TODO: implement initState
    super.initState();
  }

  bool isloaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading == true
            ? const SplashScreenCustom()
            : WebViewWidget(controller: _controllers!));
  }
}


// _loadHtmlFromAssets() async {
  //   String fileText = await rootBundle.loadString('images/token.html');
  //   _controllers!.loadFile(Uri.dataFromString(fileText,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
// }


// Scaffold(
//         body: tokens.isEmpty
//             ? const SizedBox(
//                 child: Center(
//                   child: LinearProgressIndicator(),
//                 ),
//               )
//             : WebView(
//                 initialUrl: 'https://jaggps.com',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 javascriptChannels: <JavascriptChannel>{
//                   JavascriptChannel(
//                     name: 'appChannel',
//                     onMessageReceived: (JavascriptMessage message) {
//                       if (message.message == "getToken") {
//                         _controllers!.runJavascript('receiveToken("$tokens");');
//                         // ignore: avoid_print
//                         print(
//                             'Received message from WebView: ${message.message}');
//                       }
//                     },
//                   ),
//                 },
//                 onWebViewCreated: (WebViewController webViewController) {
//                   _controllers = webViewController;
//                 },
//                 onPageFinished: (String url) {
//                   _controllers!.runJavascript('receiveToken("$tokens");');
//                 },
//               ));