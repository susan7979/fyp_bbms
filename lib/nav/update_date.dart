import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UpdateDate extends StatefulWidget {
  const UpdateDate({Key? key}) : super(key: key);

  @override
  State<UpdateDate> createState() => _UpdateDateState();
}

class _UpdateDateState extends State<UpdateDate> {
  String date = DateTime.now().toString();
  final TextEditingController _id = TextEditingController();

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return date;
    }
  }

  Future updateDate() async {
    try {
      var url = Uri.parse(
          "http://192.168.1.79/flutter-login-signup/user_dashboard/update_donated_date.php");
      var response = await http.post(url, body: {
        "id": _id.text,
        "last_donated_date": date,
      });
      var data = await json.decode(response.body);
      print(data);
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "Date updated sucessfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Update donated date"),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _id,
                decoration: InputDecoration(
                  hintText: "Enter donor id",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Select Last donated date"),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                pickDate(context);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  getText(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                updateDate();
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
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;

    setState(() => date = newDate.toString());
  }
}
