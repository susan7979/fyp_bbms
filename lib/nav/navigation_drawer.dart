import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fyp_bbms/auth/login.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/nav/blood_stock_page.dart';
import 'package:fyp_bbms/nav/nearby_organizations.dart';
import 'package:fyp_bbms/nav/post_campaigns.dart';
import 'package:fyp_bbms/nav/request_blood.dart';
import 'package:fyp_bbms/nav/update_date.dart';
import 'package:fyp_bbms/providers/auth_provider.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'faq.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late bool _serviceEnabled;

  late PermissionStatus _permissionGranted;

  LocationData? _userLocation;

  final padding = EdgeInsets.symmetric(
    horizontal: 20,
  );

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    if (!mounted) {
      setState(() {
        _userLocation = _locationData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.asset('assets/images/profile.png');
    final info = "Edit profile";
    return Drawer(
      child: Material(
        color: Colors.redAccent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // color: Colors.black45,
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 248, 116, 107),
              Color.fromARGB(255, 250, 59, 45)
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: buildHeader(
                  image: image,
                  info: info,
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Column(
                children: [
                  buildMenuItem(
                      text: 'Home',
                      icon: Icons.home,
                      onClicked: () => selectedItem(context, 0)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Request for blood',
                      icon: Icons.bloodtype,
                      onClicked: () => selectedItem(context, 1)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Update donated date',
                      icon: Icons.calendar_month,
                      onClicked: () => selectedItem(context, 2)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Nearby Organizations',
                      icon: Icons.local_hospital,
                      onClicked: () => selectedItem(context, 3)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Create Donation Campaign',
                      icon: Icons.campaign,
                      onClicked: () => selectedItem(context, 4)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Faq',
                      icon: Icons.question_answer,
                      onClicked: () => selectedItem(context, 5)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'BloodStock',
                      icon: Icons.bloodtype_rounded,
                      onClicked: () => selectedItem(context, 6)),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 7)),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required Image image,
    required String info,
  }) {
    return Container(
      child: Container(
        padding: padding.add(
          EdgeInsets.symmetric(vertical: 40),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   name,
                //   style: TextStyle(fontSize: 20, color: Colors.white),
                // ),

                Consumer<AuthProvider>(
                  builder: (context, user, _) {
                    return Text(
                      user.userName,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => UpdateDate());
                  },
                  child: Row(
                    children: [
                      Text(
                        info,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )
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

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        // Get.to(() => HomePage(), transition: Transition.rightToLeftWithFade);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        // _getUserLocation();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RequestBlood()));

        break;

      case 2:
        Get.to(() => UpdateDate(), transition: Transition.rightToLeftWithFade);
        break;
      case 3:
        Get.to(() => NearbyOrganization(),
            transition: Transition.rightToLeftWithFade);
        break;

      case 4:
        Get.to(() => PostCampaigns(),
            transition: Transition.rightToLeftWithFade);
        break;

      case 5:
        Get.to(() => Faq(), transition: Transition.rightToLeftWithFade);
        break;
      case 6:
        Get.to(() => BloodStockPage(),
            transition: Transition.rightToLeftWithFade);
        break;
      case 7:
        Provider.of<AuthProvider>(context, listen: false).logout();

        Navigator.of(context).pop();

        Get.to(() => Login(), transition: Transition.rightToLeftWithFade);
        break;
    }
  }
}
