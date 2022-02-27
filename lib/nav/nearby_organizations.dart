import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';
import 'package:fyp_bbms/nearby_organization/nearby_organization_details.dart';
import 'package:http/http.dart' as http;

class NearbyOrganization extends StatefulWidget {
  const NearbyOrganization({Key? key}) : super(key: key);

  @override
  State<NearbyOrganization> createState() => _NearbyOrganizationState();
}

class _NearbyOrganizationState extends State<NearbyOrganization> {
  List _nearbyOrganizations = [];

  getAllOrganization() async {
    var response = await http.get(Uri.parse(
        "http://192.168.1.79/flutter-login-signup/nearby_organizations.php"));
    if (response.statusCode == 200) {
      setState(() {
        _nearbyOrganizations = json.decode(response.body);
      });
      print(_nearbyOrganizations);
      return _nearbyOrganizations;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Organizations'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView.builder(
          itemCount: _nearbyOrganizations.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Text(_nearbyOrganizations[index]['name']),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NearbyOrganizationDetails(
                                name: _nearbyOrganizations[index]['name'],
                                establishedDate: _nearbyOrganizations[index]
                                    ['established_date'],
                                location: _nearbyOrganizations[index]
                                    ['location'],
                                email: _nearbyOrganizations[index]['email'],
                                phoneNumber: _nearbyOrganizations[index]
                                    ['phone_number'],
                              )));
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
