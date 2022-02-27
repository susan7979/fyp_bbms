import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    var response = await http.post(
        Uri.parse('http://192.168.1.79/flutter-login-signup/check.php'),
        body: {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Enter your email",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
            controller: _user,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    checkUser();
                  },
                  color: Colors.redAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "Send recover code",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
