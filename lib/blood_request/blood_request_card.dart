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

  @override
  Widget build(BuildContext context) {
    var index;
    return Card(
      color: Colors.red[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: Text(
                widget.bloodRequest.bloodGroup,
                style: TextStyle(fontSize: 16),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bloodRequest.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Text(
                    widget.bloodRequest.hospitalName,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.bloodRequest.hospitalAddress,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.bloodRequest.phoneNumber,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.bloodRequest.postTime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tap to see more..."),
              )
            ],
          ),
        ],
      ),
    );
  }
}
