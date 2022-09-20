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
    receiveTimeout: 15000,
    connectTimeout: 15000,
    sendTimeout: 15000,
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
        user.token = response.data["token"];

        User.setUser(user);
        return "SUCCESS";
      } else {
        error = response.data["error"] as String;
      }
    } catch (e) {}

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
    } catch (e) {
      
    }
    return [];
  }

  Future<bool> postDocument(DocumentInfo info) async {
    try {
      Response response = await _dio.post(documentsEndpoint,
          data: {"document": info.data, "title": info.title},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
      return (response.statusCode! >= 200 && response.statusCode! < 300);
    } catch (e) {}
    return false;
  }

  Future<bool> deleteDocument(String id) async {
    try {
      Response response = await _dio.post("$documentsEndpoint/$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${User.getUser()!.token}"
          }));
       return (response.statusCode! >= 200 && response.statusCode! < 300);   
    } catch (e) {}
    return false;
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
