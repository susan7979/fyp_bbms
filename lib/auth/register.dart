import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/auth/login.dart';

import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool verifyButton = false;
  String verifyLink = '';

  Future register() async {
    var url =
        Uri.parse("http://192.168.1.79/flutter-login-signup/register.php");
    var response = await http.post(url, body: {
      "username": _user.text,
      "password": _pass.text,
    });
    var link = json.decode(response.body);
    print('susan');

    setState(() {
      verifyLink = link;
      verifyButton = true;
      Fluttertoast.showToast(
          msg: "Check your mail and verify",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    sendMail();

    if (link == "Error") {
      Fluttertoast.showToast(
          msg: "This user already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MyApp(),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(
          msg: "Registration completed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Login(),
      //   ),
      // );
    }
  }

  Future verify() async {
    var response = await http.post(Uri.parse(verifyLink));

    var link = json.decode(response.body);
    setState(() {
      verifyButton = false;
    });
    print(link);
  }

  sendMail() async {
    String username = 'gautamsusan15@gmail.com';
    String password = '###asdf1234###';

    print(verifyLink);

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Susan Gautam')
      ..recipients.add('${_user.text}')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..html =
          "<h1>Verify your mail</h1>\n<p>Verify your mail and access your app</p><p> <a href='$verifyLink'>Click here to verify</a></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       icon: const Icon(
    //         Icons.arrow_back_ios,
    //         size: 20,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   body: Form(
    //     key: _formKey,
    //     child: Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 40),
    //       height: MediaQuery.of(context).size.height - 50,
    //       width: double.infinity,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             Column(
    //               children: <Widget>[
    //                 const Text(
    //                   "Sign up",
    //                   style:
    //                       TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //                 Text(
    //                   "Create an account, It's free",
    //                   style: TextStyle(fontSize: 15, color: Colors.grey[700]),
    //                 ),
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 const Text(
    //                   "Username",
    //                   style: TextStyle(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w400,
    //                       color: Colors.black87),
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 TextFormField(
    //                   validator: (value) {
    //                     if (value!.isEmpty) {
    //                       return "Please enter your username";
    //                     }
    //                     return null;
    //                   },
    //                   controller: _user,
    //                   decoration: const InputDecoration(
    //                     contentPadding:
    //                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    //                     enabledBorder: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                     border: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 30,
    //                 ),
    //                 const Text(
    //                   "Password",
    //                   style: TextStyle(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w400,
    //                       color: Colors.black87),
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 TextFormField(
    //                   validator: (value) {
    //                     if (value!.isEmpty) {
    //                       return "Please enter your password";
    //                     }
    //                     return null;
    //                   },
    //                   controller: _pass,
    //                   obscureText: true,
    //                   decoration: const InputDecoration(
    //                     contentPadding:
    //                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    //                     enabledBorder: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                     border: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 30,
    //                 ),
    //                 const Text(
    //                   "Re-enter password",
    //                   style: TextStyle(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w400,
    //                       color: Colors.black87),
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 TextFormField(
    //                   validator: (value) {
    //                     if (value!.isEmpty) {
    //                       return "Please re-enter to confirm your password";
    //                     }
    //                     if (value != _pass.text) {
    //                       return "Passwords didnt match";
    //                     }

    //                     return null;
    //                   },
    //                   controller: _confirmPass,
    //                   obscureText: true,
    //                   decoration: const InputDecoration(
    //                     contentPadding:
    //                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    //                     enabledBorder: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                     border: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFFBDBDBD))),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 30,
    //                 ),
    //               ],
    //             ),
    //             Container(
    //               padding: const EdgeInsets.only(top: 3, left: 3),
    //               // decoration: BoxDecoration(
    //               //     borderRadius: BorderRadius.circular(50),
    //               //     border: const Border(
    //               //       bottom: BorderSide(color: Colors.black),
    //               //       top: BorderSide(color: Colors.black),
    //               //       left: BorderSide(color: Colors.black),
    //               //       right: BorderSide(color: Colors.black),
    //               //     )),
    //               child: Column(
    //                 children: [
    //                   MaterialButton(
    //                     minWidth: double.infinity,
    //                     height: 60,
    //                     onPressed: () {
    //                       if (_formKey.currentState!.validate()) {
    //                         register();
    //                       }
    //                     },
    //                     color: Colors.redAccent,
    //                     elevation: 0,
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(50)),
    //                     child: const Text(
    //                       "Sign up",
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.w600, fontSize: 18),
    //                     ),
    //                   ),
    //                   // SizedBox(
    //                   //   height: 40,
    //                   // ),
    //                   // MaterialButton(
    //                   //   minWidth: double.infinity,
    //                   //   height: 60,
    //                   //   onPressed: () {
    //                   //     verify();
    //                   //   },
    //                   //   color: Colors.greenAccent,
    //                   //   elevation: 0,
    //                   //   shape: RoundedRectangleBorder(
    //                   //       borderRadius: BorderRadius.circular(50)),
    //                   //   child: const Text(
    //                   //     "Verify",
    //                   //     style: TextStyle(
    //                   //         fontWeight: FontWeight.w600, fontSize: 18),
    //                   //   ),
    //                   // ),
    //                 ],
    //               ),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 const Text("Already have an account?"),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const Login()));
    //                   },
    //                   child: const Text(
    //                     " Login",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w600, fontSize: 18),
    //                   ),
    //                 ),
    //               ],
    //             ),
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
                    "Register",
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
                  return "Please re-enter your password";
                }
                return null;
              },
              obscureText: true,
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                focusColor: Color(0xffF5591F),
                icon: Icon(
                  Icons.vpn_key,
                  color: Colors.red,
                ),
                hintText: "Re-Enter Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          //   alignment: Alignment.centerRight,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => ForgetPassword()));
          //     },
          //     child: Text("Forget Password?"),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                register();
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
                "REGISTER",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?  "),
                GestureDetector(
                  child: Text(
                    "Login Now",
                    style: TextStyle(color: Color(0xffF5591F)),
                  ),
                  onTap: () {
                    // Write Tap Code Here.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
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
