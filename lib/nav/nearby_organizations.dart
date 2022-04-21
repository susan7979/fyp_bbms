import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/nearby_organization_model.dart';
import 'package:fyp_bbms/nearby_organization/nearby_organization_details.dart';
import 'package:http/http.dart' as http;

class NearbyOrganization extends StatefulWidget {
  const NearbyOrganization({Key? key}) : super(key: key);

  @override
  State<NearbyOrganization> createState() => _NearbyOrganizationState();
}

class _NearbyOrganizationState extends State<NearbyOrganization> {
  List<NearbyOrganizationsModel> _nearbyOrganizations = [];

  Future<List<NearbyOrganizationsModel>> getAllOrganization() async {
    try {
      var response = await http.get(Uri.parse(nearbyOrganizationUrl));
      if (response.statusCode == 200) {
        final List<NearbyOrganizationsModel> _nearbyOrganizations =
            nearbyOrganizationsModelFromJson(response.body);

        print(_nearbyOrganizations);
        return _nearbyOrganizations;
      } else {
        return <NearbyOrganizationsModel>[];
      }
    } on Exception catch (e) {
      return <NearbyOrganizationsModel>[];
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOrganization();
    getAllOrganization().then((nearbyOrganization) {
      setState(() {
        _nearbyOrganizations = nearbyOrganization;
      });
    });
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
            NearbyOrganizationsModel nearbyOrganizationsModel =
                _nearbyOrganizations[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: Colors.black45,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 152, 145),
                    Color.fromARGB(255, 245, 70, 58)
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
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
                                nearbyOrganizationsModel.name,
                                style: TextStyle(fontSize: 20),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NearbyOrganizationDetails(
                                          nearbyOrganizationsModel:
                                              nearbyOrganizationsModel,
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
