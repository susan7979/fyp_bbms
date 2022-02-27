import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/auth/forget_password.dart';
import 'package:fyp_bbms/nav/register_donor.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/auth/register.dart';
import 'package:http/http.dart' as http;

import '../home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future login() async {
    var url = Uri.parse("http://192.168.1.79/flutter-login-signup/login.php");
    var response = await http.post(url, body: {
      "username": _user.text,
      "password": _pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login Succesfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
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
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       icon: const Icon(
    //         Icons.arrow_back,
    //         size: 20,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   body: Form(
    //     key: _formKey,
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       width: double.infinity,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: <Widget>[
    //                 Column(
    //                   children: <Widget>[
    //                     const Text(
    //                       "Login",
    //                       style: TextStyle(
    //                           fontSize: 30, fontWeight: FontWeight.bold),
    //                     ),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(
    //                       "Login to your account",
    //                       style:
    //                           TextStyle(fontSize: 15, color: Colors.grey[700]),
    //                     ),
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 40),
    //                   child: Column(
    //                     children: <Widget>[
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: <Widget>[
    //                           const Text(
    //                             "Username",
    //                             style: TextStyle(
    //                                 fontSize: 15,
    //                                 fontWeight: FontWeight.w400,
    //                                 color: Colors.black87),
    //                           ),
    //                           const SizedBox(
    //                             height: 5,
    //                           ),
    //                           TextFormField(
    //                             validator: (value) {
    //                               if (value!.isEmpty) {
    //                                 return "Please enter your username";
    //                               }
    //                               return null;
    //                             },
    //                             controller: _user,
    //                             decoration: const InputDecoration(
    //                               contentPadding: EdgeInsets.symmetric(
    //                                   vertical: 0, horizontal: 10),
    //                               enabledBorder: OutlineInputBorder(
    //                                   borderSide:
    //                                       BorderSide(color: Color(0xFF3366FF))),
    //                               border: OutlineInputBorder(
    //                                   borderSide:
    //                                       BorderSide(color: Color(0xFF3366FF))),
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             height: 30,
    //                           ),
    //                           const Text(
    //                             "Password",
    //                             style: TextStyle(
    //                                 fontSize: 15,
    //                                 fontWeight: FontWeight.w400,
    //                                 color: Colors.black87),
    //                           ),
    //                           const SizedBox(
    //                             height: 5,
    //                           ),
    //                           TextFormField(
    //                             validator: (value) {
    //                               if (value!.isEmpty) {
    //                                 return "Please enter your password";
    //                               }
    //                               return null;
    //                             },
    //                             controller: _pass,
    //                             obscureText: true,
    //                             decoration: const InputDecoration(
    //                               contentPadding: EdgeInsets.symmetric(
    //                                   vertical: 0, horizontal: 10),
    //                               enabledBorder: OutlineInputBorder(
    //                                   borderSide:
    //                                       BorderSide(color: Color(0xFF3366FF))),
    //                               border: OutlineInputBorder(
    //                                   borderSide:
    //                                       BorderSide(color: Color(0xFF3366FF))),
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             height: 30,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 40),
    //                   child: Container(
    //                     padding: const EdgeInsets.only(top: 3, left: 3),
    //                     // decoration: BoxDecoration(
    //                     //     borderRadius: BorderRadius.circular(50),
    //                     //     border: const Border(
    //                     //       bottom: BorderSide(color: Colors.black),
    //                     //       top: BorderSide(color: Colors.black),
    //                     //       left: BorderSide(color: Colors.black),
    //                     //       right: BorderSide(color: Colors.black),
    //                     //     )),
    //                     child: MaterialButton(
    //                       minWidth: double.infinity,
    //                       height: 60,
    //                       onPressed: () {
    //                         if (_formKey.currentState!.validate()) {
    //                           login();
    //                         }
    //                       },
    //                       color: Colors.redAccent,
    //                       elevation: 0,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(50)),
    //                       child: const Text(
    //                         "Login",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.w600, fontSize: 18),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => ForgetPassword()));
    //                       },
    //                       child: const Text(
    //                         "Forgot Password?",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.w600, fontSize: 18),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     const Text("Don't have an account?"),
    //                     InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => Register()));
    //                       },
    //                       child: const Text(
    //                         "Sign up",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.w600, fontSize: 18),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             Container(
    //               height: MediaQuery.of(context).size.height / 3,
    //               // decoration: BoxDecoration(
    //               //     image: DecorationImage(
    //               //         image: AssetImage('assets/background.png'),
    //               //         fit: BoxFit.cover)),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
              color: Colors.red,
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.redAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "assets/images/launch_image.png",
                    height: 90,
                    width: 90,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            )),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 70),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              controller: _user,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
                hintText: "Enter Email",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xffEEEEEE),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 100,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              controller: _pass,
              obscureText: true,
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                focusColor: Color(0xffF5591F),
                icon: Icon(
                  Icons.vpn_key,
                  color: Colors.red,
                ),
                hintText: "Enter Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgetPassword()));
              },
              child: Text("Forget Password?"),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                login();
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.redAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have Any Account?  "),
                GestureDetector(
                  child: Text(
                    "Register Now",
                    style: TextStyle(color: Color(0xffF5591F)),
                  ),
                  onTap: () {
                    // Write Tap Code Here.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ));
                  },
                )
              ],
            ),
          )
        ],
      )),
    ));
  }
}
