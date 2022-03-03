import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({Key? key}) : super(key: key);

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   NotificationApi.init();
  //   listenNotifications();
  // }

  // void listenNotifications() =>
  //     NotificationApi.onNotifications.stream.listen(onClickedNotification);

  // void onClickedNotification(String? payload) =>
  //     Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => HomePage(),
  //     ));
  //
  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        1,
        "Emergency blood request!!",
        "There is an emergency blood request at ${_hospitalName.text} for ${_bloodGroup.text}",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        )));
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _hospitalName = TextEditingController();
  final TextEditingController _hospitalAddress = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _bloodAmount = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  final String _postTime = DateFormat.yMEd().add_jms().format(DateTime.now());

  Future requestBlood() async {
    var url = Uri.parse(
        "http://192.168.1.79/flutter-login-signup/user_dashboard/post_request_blood.php");
    var response = await http.post(url, body: {
      "name": _name.text,
      "gender": _gender.text,
      "age": _age.text,
      "hospital_name": _hospitalName.text,
      "hospital_address": _hospitalAddress.text,
      "email": _email.text,
      "phone_number": _phoneNumber.text,
      "blood_group": _bloodGroup.text,
      "blood_amount": _bloodAmount.text,
      "reason": _reason.text,
      "post_time": _postTime,
    });
    var data = await json.decode(response.body);
    print(data);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Blood Request submitted!",
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
          msg: "Blood request failed!",
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
    return Scaffold(
      appBar: CustomAppBar(title: "Request Blood"),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: "Name"),
          ),
          TextFormField(
            controller: _gender,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your gender',
                labelText: "Gender"),
          ),
          TextFormField(
            controller: _age,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your age',
                labelText: "Age"),
          ),
          TextFormField(
            controller: _hospitalName,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.local_hospital),
                hintText: 'Enter your hospital name',
                labelText: "Hospital Name"),
          ),
          TextFormField(
            controller: _hospitalAddress,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.home),
                hintText: 'Enter your hospital address',
                labelText: "Hospital Address"),
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.email),
                hintText: 'Enter your email',
                labelText: "Email"),
          ),
          TextFormField(
            controller: _phoneNumber,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.phone),
                hintText: 'Enter your phone number',
                labelText: "Phone Number"),
          ),
          TextFormField(
            controller: _bloodGroup,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.bloodtype_rounded),
                hintText: 'Enter your blood group',
                labelText: "Blood Group"),
          ),
          TextFormField(
            controller: _bloodAmount,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.label),
                hintText: 'Enter your required amount',
                labelText: "Blood Amount"),
          ),
          TextFormField(
            controller: _reason,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.question_answer),
                hintText: 'Enter your reason',
                labelText: "Why do you need blood?"),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                requestBlood();
                showNotification();
              },
              child: Text('Request for blood'))
        ],
      ),
    );
  }
}
