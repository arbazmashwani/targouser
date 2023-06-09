import 'package:flutter/material.dart';

class SplashScreenCustom extends StatelessWidget {
  const SplashScreenCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
              height: 150, width: 150, child: Image.asset("images/Logo.png")),
        ),
      ),
    );
  }
}
