import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/models/donor_register.dart';

import '../api.dart';

class DonorRegistrationCard extends StatefulWidget {
  const DonorRegistrationCard({
    Key? key,
    required this.donorRegister,
  }) : super(key: key);

  final DonorRegister donorRegister;

  @override
  State<DonorRegistrationCard> createState() => _DonorRegistrationCardState();
}

class _DonorRegistrationCardState extends State<DonorRegistrationCard> {
  Future<bool> isEligible() async {
    if (widget.donorRegister.donationEligibility == 'non-eligible') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red[300],
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: Colors.black45,
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 255, 152, 145),
          Color.fromARGB(255, 245, 70, 58)
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            dense: false,
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: Container(
                height: 200,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      // BoxShadow(
                      //     color: Colors.redAccent.withOpacity(0.2),
                      //     spreadRadius: 5,
                      //     blurRadius: 7,
                      //     offset: const Offset(0, 3))
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                            "$rootUrl/bbms_api/images/${widget.donorRegister.profileImage}"),
                        fit: BoxFit.fill)),
              ),
            ),
            title: Container(
              // decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.donorRegister.name,
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
                          widget.donorRegister.address,
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
                      widget.donorRegister.age,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.donorRegister.bloodGroup,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.donorRegister.donationEligibility,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
              //
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
