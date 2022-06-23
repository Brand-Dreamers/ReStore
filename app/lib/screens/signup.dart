import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/profile.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hello!", style: headerTextStyle),
                const SizedBox(
                  height: 10,
                ),
                Text("Welcome to Restore.", style: subtitleTextStyle),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.mail_outline_sharp,
                                  size: 22, color: iconColor)),
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
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.lock_outline_sharp,
                                  size: 22, color: iconColor)),
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
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _confirmController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.lock_outline_sharp,
                                  size: 22, color: iconColor)),
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
                      if(password == confirmPassword)
                      {
                        User.getUser().email = email;
                        User.getUser().password = password;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text("Sign Up", style: buttonTextStyle)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Text("Sign In",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: buttonColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
