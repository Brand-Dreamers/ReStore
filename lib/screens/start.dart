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
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Image.asset(
                "assets/images/restore.png",
                height: 300,
                width: 300,
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
              Text(
                "Lorem Ipsum",
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthService()));
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
