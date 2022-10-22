import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/profile.dart';
import 'package:restore/services/authservice.dart';

class Signup extends StatefulWidget {
  final VoidCallback toggleView;
  const Signup({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _confirmControl = TextEditingController();
  final Map<String, String> _authDetails = {"email": "", "password": ""};
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    void changeScreen() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Profile()));

    void _submit() {
      FormState? currentState = _formKey.currentState;
      if (currentState != null) {
        if (!currentState.validate()) return;

        currentState.save();

        showDialog(
            useSafeArea: true,
            barrierDismissible: false,
            context: context,
            builder: (context) => const Popup(message: "Signing You Up"));

        Future<String> res =
            AuthService.getService().authenticate(_authDetails, register);

        res.then((value) {
          if (value == success) {
            _controller.text = "";
            _emailControl.text = "";
            _confirmControl.text = "";
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Account Created Successfully"),
              elevation: 1.0,
              dismissDirection: DismissDirection.down,
              duration: Duration(seconds: 3),
            ));
            changeScreen();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value),
              elevation: 1.0,
              dismissDirection: DismissDirection.down,
              duration: const Duration(seconds: 3),
            ));
            setState(() {});
          }
        });
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
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
                        fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 5,
                ),
                Text("Welcome to Restore",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 50,
                ),
                
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: fieldColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                controller: _emailControl,
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.mail_outline_rounded,
                                          size: 20, color: iconColor)),
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                controller: _controller,
                                decoration: InputDecoration(
                                    prefixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Icon(Icons.lock_outline_rounded,
                                            size: 20, color: iconColor)),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: const TextStyle(color: Colors.grey),
                                    suffixIcon: GestureDetector(
                                        child: Icon(
                                            _showPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey),
                                        onTap: () {
                                          setState(() =>
                                              _showPassword = !_showPassword);
                                        })),
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return "Password is too short. Use at least 6 characters";
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    _authDetails["password"] = value!,
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
                                controller: _confirmControl,
                                obscureText: !_showConfirmPassword,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.lock_outline_rounded,
                                          size: 20, color: iconColor)),
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  suffixIcon: GestureDetector(
                                      child: Icon(
                                          _showConfirmPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey),
                                      onTap: () {
                                        setState(() => _showConfirmPassword =
                                            !_showConfirmPassword);
                                      }),
                                ),
                                validator: (value) {
                                  if (value != _controller.text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    _authDetails["password"] = value!,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () => _submit(),
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleView(),
                      child: const Text("Log In",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 31, 119, 190))),
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
