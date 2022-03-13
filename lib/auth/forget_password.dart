import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _user = TextEditingController();

  bool verifyButton = false;
  String verifyLinkPass = '';

  Future checkUser() async {
    var response = await http.post(Uri.parse(forgotPasswordUrl), body: {
      "username": _user.text,
    });
    var linkPass = json.decode(response.body);
    if (linkPass == "INVALIDUSER") {
      Fluttertoast.showToast(
          msg: "This user is not in our database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        verifyLinkPass = linkPass;
        verifyButton = true;
      });
      sendMail();
      Fluttertoast.showToast(
          msg: "Check your mail to reset the password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print(linkPass);
  }

  sendMail() async {
    String username = 'gautamsusan15@gmail.com';
    String password = '###asdf1234###';

    print(verifyLinkPass);

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Susan Gautam')
      ..recipients.add('${_user.text}')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..html =
          "<h1>Reset your password</h1>\n<p>Click the following link to reset the password \n </p><p>  <a href='$verifyLinkPass'>Click here to verify</a></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
    }
  }

  int newPass = 0;
  Future resetPassword(String verifyLinkPass) async {
    var response = await http.post(Uri.parse(verifyLinkPass));
    var linkPass = json.decode(response.body);
    setState(() {
      newPass = linkPass;
      verifyButton = false;
    });
    print(linkPass);
    Fluttertoast.showToast(
        msg: "Your password has been reset : $newPass",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset your password."),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  checkUser();
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
                    "SEND RECOVERY MAIL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // verifyButton
          //     ? MaterialButton(
          //         child: Text("Verify"),
          //         onPressed: () {
          //           resetPassword(verifyLinkPass);
          //         },
          //       )
          //     : Container(),
          // newPass == 0 ? Container() : Text("New Password is: $newPass"),
        ],
      )),
    );
  }
}
