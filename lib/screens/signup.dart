import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/profile.dart';

class Signup extends StatefulWidget {
  final Function toggleView;
  const Signup({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

Future<bool> willPop() async {
  return false;
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text("Sign Up",
                    style: emphasizedHeader.copyWith(
                        fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 5,
                ),
                Text("Welcome to Restore",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Register with your registered school mail e.g you@school.edu.ng",
                      style: emphasizedSubheader.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: buttonColor)),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 220, 220),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.mail_outline_rounded,
                                  size: 20, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.lock_outline_rounded,
                                  size: 20, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _confirmController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.lock_outline_rounded,
                                  size: 20, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      String password = _passwordController.text.trim();
                      String confirmPassword = _confirmController.text.trim();
                      String email = _emailController.text.trim();
                      if (password == confirmPassword) {
                        User.getUser().email = email;
                        User.getUser().password = password;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text("Sign Up",
                              style: buttonTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleView(),
                      child: Text("Log In",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 31, 119, 190))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text("- OR -",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: borderColor),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/google icon.png",
                              height: 20, width: 20),
                          const SizedBox(width: 10),
                          Text("Log In With Google",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
