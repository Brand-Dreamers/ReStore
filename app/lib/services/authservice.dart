import 'package:flutter/material.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/signup.dart';

class AuthService extends StatefulWidget {
  AuthService({Key? key}) : super(key: key);
  bool toggleView = false;

  @override
  State<AuthService> createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  @override
  Widget build(BuildContext context) {
    if (widget.toggleView) {
      return const Login();
    } else {
      return const Signup();
    }
  }
}
