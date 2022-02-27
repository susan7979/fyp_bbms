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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.red[200],
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.grey[100],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donationCampaign.hostName,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      donationCampaign.campaignLocation,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      donationCampaign.phoneNumber,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // TextButton(
                //   child: const Text(
                //     'Reach out to donor',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onPressed: () {},
                // ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text(
                    'Location',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
