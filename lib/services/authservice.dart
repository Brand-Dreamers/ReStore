// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/login.dart';
import 'package:restore/screens/signup.dart';

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
    String error = "";
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

          // user.surname = response.data["firstName"] as String;
          // user.lastname = response.data["lastName"] as String;
          // user.matricNumber = response.data["matricNumber"] as String;
          // user.level = response.data["level"] as String;
          // user.college = response.data["college"] as String;
          // user.telephone = response.data["telephone"] as String;
          // user.department = response.data["department"] as String;
          print(userResp);
        }

        User.setUser(user);
        return success;
      } else {
        error = response.data["error"] as String;
      }
    } catch (e) {
      error = e.toString();
    }

    return error;
  }

  Future<List<DocumentInfo>> getUserDocuments() async {
    try {
      Response response = await _dio.get(documentsEndpoint,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<DocumentInfo> documents = [];
        List<dynamic> userDocuments = response.data as List<dynamic>;
        for (var element in userDocuments) {
          DocumentInfo info = DocumentInfo();
          info.title = element["title"];
          info.data = element["document"];
          info.id = element["_id"];
          documents.add(info);
        }
        return documents;
      }
    } catch (e) {}
    return [];
  }

  Future<String> profile(Map<String, String> authDetails) async {
    String msg = "";
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
    } catch (e) {
      msg = e.toString();
    }
    return msg;
  }

  Future<String> postDocument(DocumentInfo info) async {
    String res = "";
    try {
      Response response = await _dio.post(documentsEndpoint,
          data: {"document": info.data, "title": info.title},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        res = success;
      } else {
        res = response.data["message"];
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deleteDocument(String id) async {
    String res = "";
    try {
      Response response = await _dio.delete("$documentsEndpoint/$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        res = success;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

class _AuthServiceState extends State<AuthService> {
  bool showSignUp = false;

  void toggleView() => setState(() => showSignUp = !showSignUp);
  void logout() => setState(() => showSignUp = false);

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
