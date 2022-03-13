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
      color: Colors.red[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red,
                child: Text(
                  donorRegister.bloodGroup,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            title: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donorRegister.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Divider(
                    //   color: Colors.black,
                    //   thickness: 1,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          donorRegister.address,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                    Text(
                      donorRegister.age,
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   widget.bloodRequest.phoneNumber,
                    //   style: TextStyle(fontSize: 18),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
