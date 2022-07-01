import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/signup.dart';

const int success = 200;

class AuthService extends StatefulWidget {
  AuthService({Key? key}) : super(key: key);
  
  @override
  State<AuthService> createState() => _AuthServiceState();
}

Future<User?> getUser(String username, String password) async {
  try {
    var url = Uri.parse(baseURL + usersEndpoint + login);
    Map<String, String> body = {"name": username, "password": password};
    Response response = await post(url, body: body);
    if (response.statusCode == success) {
      return User.fromJson(response.body);
    }
  } catch (e) {return null;}
  return null;
}

class _AuthServiceState extends State<AuthService> {
  
  bool showSignUp = false;

  void toggleView() => setState(() => showSignUp = !showSignUp);

  @override
  Widget build(BuildContext context) {
    if (showSignUp) {
      return Signup(toggleView: toggleView,);
    } else {
      return Login(toggleView: toggleView,);
    }
  }
}
