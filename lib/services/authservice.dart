import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/signup.dart';

const int success = 200;

class AuthService extends StatefulWidget {
  static final AuthService _authservice = AuthService();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseURL,
    receiveTimeout: 15000,
    connectTimeout: 15000,
    sendTimeout: 15000,
  ));
  AuthService({Key? key}) : super(key: key);

  @override
  State<AuthService> createState() => _AuthServiceState();

  static AuthService getService() => _authservice;

  Future<bool> authenticate(
      Map<String, String> authDetails, String authPath) async {
    try {
      Response response = await _dio.post(
        users + authPath,
        data: authDetails,
      );
      User user = User.fromJson(response.data);
      user.email = authDetails["email"] as String;
      user.password = authDetails["password"] as String;
      User.setUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> profile(Map<String, String> authDetails) async {
    try {
      Response response = await _dio.put(users, data: authDetails);
      User user = User.fromJson(response.data);
      User.setUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> avatar(String avatarURL) async {
    try {
      Response response = await _dio.put(users, data: {"avatarURL": avatarURL});
      User user = User.fromJson(response.data);
      User.setUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class _AuthServiceState extends State<AuthService> {
  bool showSignUp = false;

  void toggleView() => setState(() => showSignUp = !showSignUp);

  @override
  Widget build(BuildContext context) {
    if (showSignUp) {
      return Signup(
        toggleView: toggleView,
      );
    } else {
      return Login(
        toggleView: toggleView,
      );
    }
  }
}
