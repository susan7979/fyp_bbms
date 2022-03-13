import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/home.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _tokenKey;
  bool _isAuthOnGoing;
  String _userName = '';

  final SessionManager _sessionManager;

  AuthProvider()
      : _sessionManager = SessionManager(),
        _isAuthOnGoing = false;

  bool get isAuth {
    return _tokenKey != null;
  }

  String get userName => _userName;

  set userName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  String? get tokenKey => _tokenKey;

  bool get isAuthOnGoing => _isAuthOnGoing;

  // Future<void> _authenticate(String username, String password) async {
  //   _isAuthOnGoing = true;
  //   try {
  //     final response = await http.post(
  //       Uri.parse(LOGIN),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json'
  //       },
  //       body: json.encode(
  //         {
  //           "username": username,
  //           "email": "",
  //           "password": password,
  //         },
  //       ),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['non_field_errors'] != null) {
  //       throw HttpException(responseData['non_field_errors'][0]);
  //     }
  //     await Future.delayed(const Duration(seconds: 1));
  //     _tokenKey = responseData['key'];
  //     _sessionManager.set('tokenKey', _tokenKey);
  //   } catch (error) {
  //     _tokenKey = null;
  //   }
  //   _isAuthOnGoing = false;
  //   notifyListeners();
  // }

  // Future<void> signup(String email, String password) async {
  //   return _authenticate(email, password);
  // }
  Future login(String username, String password) async {
    var url = Uri.parse(loginUrl);
    var response = await http.post(url, body: {
      "username": username,
      "password": password,
    });
    var data = json.decode(response.body);

    print(data);

    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login Succesfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (BuildContext context) => HomePage(),
      // ));
      Get.to(() => HomePage());
    } else {
      Fluttertoast.showToast(
          msg: "Login failed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }
  // Future<void> login(String username, String password) async =>
  //     _authenticate(username, password);

  // Future<void> tryAutoLogin() async {
  //   String? _ = await _sessionManager.get('tokenKey');
  //   await Future.delayed(Duration(seconds: 2));
  //   if (_ == null) return;
  //   _tokenKey = _;
  // }

  // return type: bool represents if the method executed successfully.
  // Future<bool> logout() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${getHostName()}$logoutEndpoint'),
  //       headers: {
  //         'Authorization': 'Token $_tokenKey',
  //       },
  //     );
  //     if (response.statusCode >= 400) {
  //       throw HttpException(json.decode(response.body)['detail']);
  //     }
  //     await Future.delayed(const Duration(seconds: 1));
  //     await _sessionManager.remove('tokenKey');
  //     _tokenKey = null;
  //   } catch (error) {
  //     return false;
  //   }
  //   return true;
  // }

  // Future<bool> resetPassword(String email) async {
  //   try {
  //     await http.post(
  //       Uri.parse('${getHostName()}$passwordResetEndpoint'),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         "email": email,
  //       }),
  //     );
  //   } catch (error) {
  //     return false;
  //   }
  //   return true;
  // }
}
