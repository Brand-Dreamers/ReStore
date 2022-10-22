import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/services/authservice.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:restore/screens/start.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder(
          future: IsFirstRun.isFirstRun(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold();
            } else {
              bool res = snapshot.data as bool;
              return AnimatedSplashScreen(
                backgroundColor: backgroundColor,
                splash: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Restore",
                      style: TextStyle( fontFamily: "Poppins",
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: buttonColor),
                    ),
                    Text("By The Dreamers",
                        style: emphasizedSubheader.copyWith(fontSize: 14, fontWeight: FontWeight.w300))
                  ],
                ),
                nextScreen:
                    res ? const SlideContainer() : AuthService.getService(),
                splashTransition: SplashTransition.fadeTransition,
                duration: 1500,
              );
            }
          }),
    );
  }
}
