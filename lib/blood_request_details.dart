import 'package:flutter/material.dart';

import 'package:fyp_bbms/models/blood_request.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodRequestDetails extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String hospitalName;
  final String hospitalAddress;
  final String email;
  final String phoneNumber;
  final String bloodGroup;
  final String bloodAmount;
  final String reason;

  BloodRequestDetails({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.bloodAmount,
    required this.reason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              gender,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              age,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              hospitalName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              hospitalAddress,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bloodGroup,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bloodAmount,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              reason,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    launch('mailto:$email');
                  },
                  icon: Icon(
                    Icons.mail,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launch('tel:$phoneNumber');
                  },
                  icon: Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Share.share('check out my website https://example.com');
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
