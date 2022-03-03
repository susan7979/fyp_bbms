import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/models/donor_register.dart';

class DonorRegistrationCard extends StatelessWidget {
  const DonorRegistrationCard({
    Key? key,
    required this.donorRegister,
  }) : super(key: key);

  final DonorRegister donorRegister;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.red[200],
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
                  donorRegister.bloodGroup,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donorRegister.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Text(
                      donorRegister.bloodGroup,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      donorRegister.address,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tap to see more"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
