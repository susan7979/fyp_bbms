import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NearbyOrganization extends StatefulWidget {
  const NearbyOrganization({Key? key}) : super(key: key);

  @override
  State<NearbyOrganization> createState() => _NearbyOrganizationState();
}

class _NearbyOrganizationState extends State<NearbyOrganization> {
  List _nearbyOrganizations = [];

  getAllBloodRequest() async {
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
    getAllBloodRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Organizaiton"),
      ),
      body: ListView.builder(
          itemCount: _nearbyOrganizations.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Text(_nearbyOrganizations[index]['name']),
                  )
                ],
              ),
            );
          }),
    );
  }
}
