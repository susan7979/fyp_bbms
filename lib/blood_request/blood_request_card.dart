import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:http/http.dart' as http;

class BloodRequestCard extends StatefulWidget {
  const BloodRequestCard({
    Key? key,
    required this.bloodRequest,
  }) : super(key: key);

  final BloodRequest bloodRequest;

  @override
  State<BloodRequestCard> createState() => _BloodRequestCardState();
}

class _BloodRequestCardState extends State<BloodRequestCard> {
  List _bloodReq = [];

  getBlood() async {
    var response = await http.get(Uri.parse(
        "http://192.168.1.79/flutter-login-signup/user_dashboard/request_blood.php"));
    if (response.statusCode == 200) {
      setState(() {
        _bloodReq = json.decode(response.body);
      });

      return _bloodReq;
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getBlood();
  }

  @override
  Widget build(BuildContext context) {
    var index;
    return Card(
      color: Colors.red[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: ListTile(
                leading: FaIcon(FontAwesomeIcons.user),
                title: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bloodRequest.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        _bloodReq[index]['post_time'],
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.bloodRequest.bloodGroup,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.bloodRequest.hospitalName,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.bloodRequest.hospitalAddress,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Contact Patient',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text(
                    'Location',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
