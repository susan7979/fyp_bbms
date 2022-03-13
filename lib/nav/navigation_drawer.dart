import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_bbms/auth/login.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/nav/nearby_organizations.dart';
import 'package:fyp_bbms/nav/post_campaigns.dart';
import 'package:fyp_bbms/nav/request_blood.dart';
import 'package:fyp_bbms/nav/update_date.dart';
import 'package:fyp_bbms/providers/auth_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'about_me.dart';
import 'register_donor.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(
    horizontal: 20,
  );
  @override
  Widget build(BuildContext context) {
    final image = Image.asset('assets/images/profile.png');
    final info = "Edit profile";
    return Drawer(
      child: Material(
        color: Colors.redAccent,
        child: ListView(
          children: <Widget>[
            buildHeader(
              image: image,
              info: info,
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
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
                      text: 'Update donated date',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 3)),
                  const SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                      text: 'Nearby Organizations',
                      icon: Icons.local_hospital,
                      onClicked: () => selectedItem(context, 4)),
                  const SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                      text: 'Create Donation Campaign',
                      icon: Icons.campaign,
                      onClicked: () => selectedItem(context, 5)),
                  const SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                      text: 'About me',
                      icon: Icons.shield,
                      onClicked: () => selectedItem(context, 6)),
                  const SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 7)),
                ],
              ),
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
                        style: TextStyle(fontSize: 14, color: Colors.white),
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

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
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
          builder: (context) => RegisterDonor(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpdateDate(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NearbyOrganization(),
        ));
        break;

      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostCampaigns(),
        ));
        break;

      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutMe(),
        ));
        break;
      case 7:
        Navigator.of(context).pop();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Login(),
        ));
        break;
    }
  }
}
