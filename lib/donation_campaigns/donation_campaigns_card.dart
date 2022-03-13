import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:fyp_bbms/models/model_donation_campaigns.dart';

class DonationCampaignsCard extends StatelessWidget {
  const DonationCampaignsCard({
    Key? key,
    required this.donationCampaign,
  }) : super(key: key);

  final DonationCampaigns donationCampaign;

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
                child: FaIcon(
                  FontAwesomeIcons.hospitalAlt,
                  size: 50,
                )),
            title: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donationCampaign.campaignLocation,
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
                          donationCampaign.phoneNumber,
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
                      donationCampaign.campaignDate,
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
