import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/auth/forget_password.dart';
import 'package:fyp_bbms/api.dart';

import 'package:fyp_bbms/auth/register.dart';
import 'package:fyp_bbms/providers/auth_provider.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 200.0,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 540.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              Positioned(
                top: 80.0,
                left: MediaQuery.of(context).size.width - 170.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/launch_image.png'))),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'BloodSource',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                        //   child: Text(
                        //     '',
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 25.0),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Positioned(
                  top: 290.0,
                  left: 40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome to',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'BloodSource',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                          //   child: Text(
                          //     'Save Lives',
                          //     style: TextStyle(
                          //         color: Colors.red,
                          //         fontWeight: FontWeight.w800,
                          //         fontSize: 12.0),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please sign in to continue',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          width: 265.0,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            controller: _user,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 265.0,
                          child: TextFormField(
                            obscureText: true,
                            validator: validatePassword,
                            controller: _pass,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                          },
                          child: Text("Forget Password?"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Row(
                          children: [
                            Text("Don't Have Any Account?  "),
                            Container(
                              width: 100.0,
                              height: 40.0,
                              child: RaisedButton(
                                splashColor: Colors.yellow,
                                color: Colors.blue,
                                padding: EdgeInsets.all(12.0),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Register()));
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 130.0,
                left: MediaQuery.of(context).size.width - 200.0,
                child: Container(
                  width: 100.0,
                  height: 40.0,
                  child: RaisedButton(
                    splashColor: Colors.yellow,
                    color: Colors.blue,
                    padding: EdgeInsets.all(12.0),
                    shape: StadiumBorder(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<AuthProvider>(context, listen: false).login(
                          _user.text,
                          _pass.text,
                        );
                        context.read<AuthProvider>().userName = _user.text;

                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //   builder: (BuildContext context) => HomePage(),
                        // ));

                        // login();
                      }
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 80.0);

    var firstControlPoint = new Offset(50.0, size.height);
    var firstEndPoint = new Offset(size.width / 3.5, size.height - 45.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width - 30.0, size.height / 2);

    var secondControlPoint =
        new Offset(size.width + 15.0, size.height / 2 - 60.0);
    var secondEndPoint = new Offset(140.0, 50.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = new Offset(50.0, 0.0);
    var thirdEndPoint = new Offset(0.0, 100.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
