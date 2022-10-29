// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/landing_page.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/signup.dart';
import 'package:restore/components/pdf_handler.dart';

class AuthService extends StatefulWidget {
  static final AuthService _authservice = AuthService();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseURL,
    receiveTimeout: 40000,
    connectTimeout: 20000,
    sendTimeout: 40000,
  ));
  AuthService({Key? key}) : super(key: key);

  @override
  State<AuthService> createState() => _AuthServiceState();

  static AuthService getService() => _authservice;

  Future<String> authenticate(
      Map<String, String> authDetails, String authPath) async {
    try {
      Response response = await _dio.post(
        "$users$authPath",
        data: authDetails,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        User user = User();

        user.email = response.data["user"]["email"];
        user.admin = response.data["user"]["admin"];
        user.id = response.data["user"]["_id"];
        user.token = response.data["token"];

        if (authPath == login) {
          Response userResp = await _dio.get("$users/user",
              options: Options(headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer ${user.token}"
              }));

          user.surname = userResp.data["firstName"] as String;
          user.lastname = userResp.data["lastName"] as String;
          user.matricNumber = userResp.data["matricNumber"] as String;
          user.level = userResp.data["level"] as String;
          user.college = userResp.data["college"] as String;
          user.telephone = userResp.data["telephone"] as String;
          user.department = userResp.data["department"] as String;
        }
        saveUserData(
            authDetails["email"] as String, authDetails["password"] as String);
        User.setUser(user);
        return success;
      }
    } catch (e) {}

    return "Wrong Email Or Password";
  }

  Future<List<PDFData>> getUserDocuments() async {
    try {
      Response response = await _dio.get(documentsEndpoint,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<PDFData> documents = [];
        List<dynamic> userDocuments = response.data as List<dynamic>;
        for (var element in userDocuments) {
          PDFData info = PDFData();
          info.filename = element["title"];
          info.encodedData = element["document"];
          info.documentId = element["_id"];
          documents.add(info);
        }
        return documents;
      }
    } catch (e) {}
    return [];
  }

  Future<String> profile(Map<String, String> authDetails) async {
    User user = User.getUser()!;
    authDetails["avatar"] = user.email;

    try {
      Response response = await _dio.put("$users/update-profile",
          data: authDetails,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        user.surname = authDetails["firstName"] as String;
        user.lastname = authDetails["lastName"] as String;
        user.matricNumber = authDetails["matricNumber"] as String;
        user.level = authDetails["level"] as String;
        user.college = authDetails["college"] as String;
        user.telephone = authDetails["telephone"] as String;
        user.department = authDetails["department"] as String;
        return success;
      }
    } catch (e) {}
    return "Something Went Wrong. Please Try Again";
  }

  Future<String> postDocument(PDFData info) async {
    try {
      Response response = await _dio.post(documentsEndpoint,
          data: {"document": info.data, "title": info.filename},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return success;
      }
    } catch (e) {}
    return "An Error Occurred While Uploading. Please Try Again";
  }

  Future<String> deleteDocument(String id) async {
    try {
      Response response = await _dio.delete("$documentsEndpoint/$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return success;
      }
    } catch (e) {}
    return "An Error Occurred While Deleting. Please Try Again";
  }
}

class _AuthServiceState extends State<AuthService> {
  bool showSignUp = false;
  bool _firstRun = true;

  void toggleView() => setState(() => showSignUp = !showSignUp);

  Widget _getWidget() {
    Widget w;
    if (_firstRun && hasUserData()) {
      List<String> data = loadUserData();
      Map<String, String> authDetails = {"email": data[0], "password": data[1]};
      AuthService.getService().authenticate(authDetails, login);
      w = const LandingPage();
    } else {
      if (showSignUp) {
        w = Signup(toggleView: toggleView);
      } else {
        w = Login(toggleView: toggleView);
      }
    }
    _firstRun = false;
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return _getWidget();
  }
}
