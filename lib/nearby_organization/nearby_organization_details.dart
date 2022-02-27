import 'package:flutter/material.dart';

import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';

class NearbyOrganizationDetails extends StatelessWidget {
  final String name;
  final String establishedDate;
  final String location;
  final String email;
  final String phoneNumber;
  NearbyOrganizationDetails({
    required this.name,
    required this.establishedDate,
    required this.location,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: name),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red.shade800,
        icon: const Icon(Icons.payment),
        label: Text('Donate'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => KhaltiPaymentApp(),
          ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.red[200],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  establishedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.red[400],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.red[400],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.red[400],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  phoneNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.red[400],
            ),
          ],
        ),
      ),
    );
  }
}
