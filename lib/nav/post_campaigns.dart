import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final TextEditingController _hostName = TextEditingController();
  final TextEditingController _campaignLocation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _campaignDescription = TextEditingController();
  final TextEditingController _campaignDate = TextEditingController();

  Future postCampaigns() async {
    var url = Uri.parse(
        "http://192.168.1.79/flutter-login-signup/user_dashboard/post_campaigns.php");
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _hostName,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Campaign Host',
                labelText: "Host"),
          ),
          TextFormField(
            controller: _campaignLocation,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.home),
                hintText: 'Enter Campaign Location',
                labelText: "Campaign Location"),
          ),
          TextFormField(
            controller: _campaignDate,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.date_range),
                hintText: 'Campaign Date',
                labelText: "Campaign Date"),
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.email),
                hintText: 'Email for queries',
                labelText: "Email"),
          ),
          TextFormField(
            controller: _phoneNumber,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.phone),
                hintText: "Enter manager's phone number",
                labelText: "Phone Number"),
          ),
          TextFormField(
            controller: _campaignDescription,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.question_answer),
                hintText: 'Enter campaign description',
                labelText: "Campaign Description"),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                postCampaigns();
                showNotification();
                // NotificationApi.showNotification(
                //     title: "New campaign soon!",
                //     body:
                //         "There is a campaign being host at ${_campaignLocation.text}",
                //     payload: 'hi');
              },
              child: Text('Share campaign'))
        ],
      ),
    );
  }
}
