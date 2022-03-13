import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/api.dart';
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
    var response = await http.get(Uri.parse(nearbyOrganizationUrl));
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
        title: Text(
          "Nearby Organizations",
          style: TextStyle(color: Colors.red[800]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
          itemCount: _nearbyOrganizations.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.red[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                        leading: FaIcon(FontAwesomeIcons.hospitalAlt),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Text(
                                _nearbyOrganizations[index]['name'],
                                style: TextStyle(fontSize: 20),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NearbyOrganizationDetails(
                                          name: _nearbyOrganizations[index]
                                              ['name'],
                                          establishedDate:
                                              _nearbyOrganizations[index]
                                                  ['established_date'],
                                          location: _nearbyOrganizations[index]
                                              ['location'],
                                          email: _nearbyOrganizations[index]
                                              ['email'],
                                          phoneNumber:
                                              _nearbyOrganizations[index]
                                                  ['phone_number'],
                                        )));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
