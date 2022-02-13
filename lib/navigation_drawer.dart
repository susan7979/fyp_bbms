import 'package:flutter/material.dart';
import 'package:fyp_bbms/filter_a_negative.dart';
import 'package:fyp_bbms/filter_a_positive.dart';
import 'package:fyp_bbms/filter_ab_negative.dart';
import 'package:fyp_bbms/filter_ab_positive.dart';
import 'package:fyp_bbms/filter_b_negative.dart';
import 'package:fyp_bbms/filter_b_positive.dart';
import 'package:fyp_bbms/filter_o_negative.dart';
import 'package:fyp_bbms/filter_o_positive.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/nearby_organizations.dart';
import 'package:fyp_bbms/request_blood.dart';

import 'about_me.dart';
import 'donate_blood.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(
    horizontal: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Request for blood',
                icon: Icons.bloodtype,
                onClicked: () => selectedItem(context, 1)),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Register for Donating blood',
                icon: Icons.arrow_forward_rounded,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Nearby Organizations',
                icon: Icons.local_hospital,
                onClicked: () => selectedItem(context, 3)),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'About me',
                icon: Icons.shield,
                onClicked: () => selectedItem(context, 4)),
            const SizedBox(
              height: 48,
            ),
            const Divider(color: Colors.white70),
            const Text(
              'Blood Groups',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'A+',
                // image: Image.asset(
                //   "assets/images/aplus.png",
                //   width: 10,
                //   height: 10,
                // ),
                onClicked: () => selectedItem(context, 5)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'A Negative', onClicked: () => selectedItem(context, 6)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'B Positive', onClicked: () => selectedItem(context, 7)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'B Negative', onClicked: () => selectedItem(context, 8)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'AB Positive', onClicked: () => selectedItem(context, 9)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: 'AB Negative',
                onClicked: () => selectedItem(context, 10)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: '0 Positive', onClicked: () => selectedItem(context, 11)),
            const SizedBox(
              height: 24,
            ),
            buildBloodGroupItem(
                text: '0 Negative', onClicked: () => selectedItem(context, 12)),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(
          color: color,
        ),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget buildBloodGroupItem({required String text, VoidCallback? onClicked}) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: color, fontSize: 20),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RequestBlood(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DonatePage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NearbyOrganization(),
        ));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutMe(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterAPositive(),
        ));
        break;

      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterANegative(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterBPositive(),
        ));
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterBNegative(),
        ));
        break;
      case 9:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterABPositive(),
        ));
        break;
      case 10:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterABNegative(),
        ));
        break;
      case 11:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterOPositive(),
        ));
        break;
      case 12:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterONegative(),
        ));
    }
  }
}
