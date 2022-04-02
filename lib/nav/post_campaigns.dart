import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
// import 'package:fyp_bbms/misc/notification_api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PostCampaigns extends StatefulWidget {
  const PostCampaigns({Key? key}) : super(key: key);

  @override
  State<PostCampaigns> createState() => _PostCampaignsState();
}

class _PostCampaignsState extends State<PostCampaigns> {
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
        "New campaign soon!",
        "There is a campaign being host at ${_campaignLocation.text}",
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hostName = TextEditingController();
  final TextEditingController _campaignLocation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _campaignDescription = TextEditingController();
  final TextEditingController _campaignDate = TextEditingController();

  Future postCampaigns() async {
    var url = Uri.parse(postCampaignsUrl);
    var response = await http.post(url, body: {
      "host_name": _hostName.text,
      "campaign_location": _campaignLocation.text,
      "email": _email.text,
      "phone_number": _phoneNumber.text,
      "campaign_description": _campaignDescription.text,
      "campaign_date": _campaignDate.text,
    });
    var data = await json.decode(response.body);
    print(data);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Campaign Posted!",
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
          msg: "Post failed!",
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
      appBar: CustomAppBar(title: "Donation Campaigns"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            hostNameTextField(),
            campaignLocationFormField(),
            campaignDateFormField(),
            emailTextField(),
            phoneNumberFormField(),
            campaignDescriptionFormField(),

            const SizedBox(
              height: 40,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       // NotificationApi.showNotification(
            //       //     title: "New campaign soon!",
            //       //     body:
            //       //         "There is a campaign being host at ${_campaignLocation.text}",
            //       //     payload: 'hi');
            //     },
            //     child: Text('Share campaign')),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  postCampaigns();
                  showNotification();
                }
              },
              child: postCampaignsBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget hostNameTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter campaign host name";
          }
          return null;
        },
        controller: _hostName,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.red,
          ),
          hintText: "Campaign host",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget campaignLocationFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your campaign location";
          }
          return null;
        },
        controller: _campaignLocation,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
          ),
          hintText: "Campaign Location",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter host email";
          }
          return null;
        },
        controller: _email,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.red,
          ),
          hintText: "Email for queries",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget campaignDateFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter the date";
          }
          return null;
        },
        controller: _campaignDate,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.calendar_month,
            color: Colors.red,
          ),
          hintText: "Campaign Date",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget phoneNumberFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter Phone number ";
          }
          return null;
        },
        controller: _phoneNumber,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: Colors.red,
          ),
          hintText: "Phone number",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget campaignDescriptionFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter campaign description";
          }
          return null;
        },
        controller: _campaignLocation,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.comment,
            color: Colors.red,
          ),
          hintText: "Campaign Description",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget postCampaignsBtn() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
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
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: Text(
        "Post Campaign",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
