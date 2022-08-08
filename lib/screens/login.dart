import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/landing_page.dart';
import 'package:restore/services/authservice.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authDetails = {"email": "", "password": ""};
  bool _showPassword = false;

  Future _submit() async {
    FormState? currentState = _formKey.currentState;
    if (currentState != null) {
      if (!currentState.validate()) return;

      currentState.save();
      bool success =
          await AuthService.getService().authenticate(_authDetails, "/signin");
      if (success) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
      }
    }
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
                Text("Log In",
                    style: emphasizedHeader.copyWith(
                        fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 5,
                ),
                Text("Hi, Welcome back!",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Log in with your registered school mail e.g you@school.edu.ng",
                      style: emphasizedSubheader.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: buttonColor)),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: fieldColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Icons.mail_outline_rounded,
                                        size: 20, color: iconColor)),
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle:
                                    GoogleFonts.poppins(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Invalid Email Address";
                                }
                                return null;
                              },
                              onSaved: (value) =>
                                  _authDetails["email"] = value!,
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
                            child: TextFormField(
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.lock_outline_rounded,
                                          size: 20, color: iconColor)),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                      GoogleFonts.poppins(color: Colors.grey),
                                  suffixIcon: GestureDetector(
                                      child: Icon(
                                          _showPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey),
                                      onTap: () {
                                        setState(() =>
                                            _showPassword = !_showPassword);
                                      })),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return "Password is too short. Use atleast 6 characters";
                                }
                                return null;
                              },
                              onSaved: (value) =>
                                  _authDetails["password"] = value!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      _submit();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text("Log In",
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
                  children: [
                    Text("Forgot Password?, ",
                        style: GoogleFonts.poppins(fontSize: 12)),
                    Text("Click Here",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 180, 21, 10))),
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
                          Text("Log In With Google",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
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
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleView(),
                      child: Text("Sign Up",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
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
