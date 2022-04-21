import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/home.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AuthProvider with ChangeNotifier {
  String? _tokenKey;
  bool _isAuthOnGoing;
  String _userName;
  int _id;
  Image? _image;

  final SessionManager _sessionManager;

  AuthProvider()
      : _sessionManager = SessionManager(),
        _isAuthOnGoing = false,
        _id = 0,
        _userName = '';

  bool get isAuth {
    return _tokenKey != null;
  }

  String get userName {
    return _userName;
    notifyListeners();
  }

  int get id => _id;
  Image? get image => _image;

  set userName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  set id(int id) {
    _id = id;
    notifyListeners();
  }

  String? get tokenKey => _tokenKey;

  set tokenKey(String? tokenKey) {
    _tokenKey = tokenKey;
    notifyListeners();
  }

  bool get isAuthOnGoing => _isAuthOnGoing;

  Future<void> login(String username, dynamic password) async {
    var url = Uri.parse(loginUrl);
    var response = await http.post(url, body: {
      "username": username,
      "password": password,
    });
    var data = json.decode(response.body);

    print(data);
    print(" User name ${data['username']}");
    // savePref(1, data['username']);

    if (data['msg'] == "success") {
      await SessionManager().set('token', username);
      // await SessionManager().set('username', username);
      Fluttertoast.showToast(
          msg: "Login Succesfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0);

      // Builder(builder: (context){
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (BuildContext context) => HomePage(),
      // ));
      // });
      Get.off(() => HomePage(), transition: Transition.rightToLeft);
      // navigatorKey.currentState
      //     ?.pushNamed('/home'); // navigate to login, with null-aware check

    } else {
      Fluttertoast.showToast(
          msg: "Login failed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }
  // Future<void> login(String username, String password) async =>
  //     _authenticate(username, password);

  Future<void> tryAutoLogin() async {
    _tokenKey = await SessionManager().get('token');
    _userName = await SessionManager().get('token');

    print(_tokenKey);
    notifyListeners();
  }

  Future<void> logout() async {
    _tokenKey = await SessionManager().set('token', '');
    notifyListeners();
    // _userName = await SessionManager().get('username');
  }

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
