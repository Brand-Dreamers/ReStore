import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/services/authservice.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  Future<bool> _onBackPressed() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/welcome.png",
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "WELCOME TO RESTORE",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: headerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Save yourself the stress of manually stamping your documents." "\nWith Restore, you can get it stamped within the hour." +
                    "\nYou can also upload your documents for future use.",
                  style: subtitleTextStyle,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthService()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text("Get Started", style: buttonTextStyle)),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
