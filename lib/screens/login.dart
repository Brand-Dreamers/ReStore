import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/home.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

Future<bool> willPop() async {
  return false;
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  height: 80,
                ),
                Text("Log In",
                    style: emphasizedHeader.copyWith(
                        fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text("Welcome back, we've missed you!",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Log in with your registered school mail",
                      style: emphasizedSubheader.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: buttonColor)),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("e.g you@school.edu.ng",
                      style: emphasizedSubheader.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: buttonColor)),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      String password = _passwordController.text.trim();
                      String email = _emailController.text.trim();
                      User.getUser().email = email;
                      User.getUser().password = password;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:
                          Center(child: Text("Log In", style: buttonTextStyle)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forgot Password?, ",
                        style: GoogleFonts.poppins(fontSize: 16)),
                    Text("Click Here",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 180, 21, 10))),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleView(),
                      child: Text("Sign Up",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 31, 119, 190))),
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
