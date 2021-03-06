import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/start.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  Future<bool> _onBackPressed() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: AnimatedSplashScreen(
        backgroundColor: backgroundColor,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Restore",
              style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: buttonColor),
            ),
            Text("By The Dreamers",
                style: GoogleFonts.poppins(fontSize: 14, color: subtitleColor))
          ],
        ),
        nextScreen: const Start(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 1500,
      ),
    );
  }
}
