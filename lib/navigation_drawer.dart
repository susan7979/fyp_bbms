import 'package:flutter/material.dart';
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
        style: TextStyle(color: color),
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
    }
  }
}
