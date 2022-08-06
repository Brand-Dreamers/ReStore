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
  late bool _showPassword;
  late bool _showConfirmPassword;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _showConfirmPassword = false;
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
                  height: 50,
                ),
                Text("Sign Up",
                    style: emphasizedHeader.copyWith(
                        fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 5,
                ),
                Text("Welcome to Restore",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 50,
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.mail_outline_rounded,
                                  size: 20, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
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
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                            prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.lock_outline_rounded,
                                    size: 20, color: iconColor)),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            suffixIcon: GestureDetector(
                                child: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey),
                                onTap: () {
                                  setState(() => _showPassword = !_showPassword);
                                })),
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
                        obscureText: !_showConfirmPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.lock_outline_rounded,
                                  size: 20, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
                          suffixIcon: GestureDetector(
                              child: Icon(_showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey),
                              onTap: () {
                                setState(() =>
                                    _showConfirmPassword = !_showConfirmPassword);
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text("Sign Up",
                              style: buttonTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
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
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleView(),
                      child: Text("Log In",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 31, 119, 190))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("- OR -",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
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
                              height: 40, width: 40),
                          const SizedBox(width: 10),
                          Text("Sign Up With Google",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
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
