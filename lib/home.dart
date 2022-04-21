import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/nav/post_campaigns.dart';
import 'package:fyp_bbms/nav/request_blood.dart';
import 'bottom_nav/blood_request_page.dart';
import 'bottom_nav/campaigns_post_page.dart';
import 'bottom_nav/donor_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int index = 0;
  final screens = [
    BloodRequestPage(),
    DonorListPage(),
    CampaignsPostPage(),
  ];
  bool _loading = true;
  bool isSearching = false;
  final isDialOpen = ValueNotifier(false);

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        // appBar: CustomAppBar(
        //   title: 'BloodSource',
        // ),
        key: _drawerKey,

        // drawer: NavigationDrawer(),
        body: screens[_selectedIndex],
        extendBody: true,
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.white,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          openCloseDial: isDialOpen,
          foregroundColor: Colors.red,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.red[300],
                label: 'Request blood',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RequestBlood()));
                }),
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.red[300],
                label: 'Create a donation campaign',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PostCampaigns()));
                }),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 300),
              color: Color.fromARGB(255, 243, 58, 58),
              buttonBackgroundColor: Colors.red,
              height: 50,
              backgroundColor: Colors.transparent,
              items: <Widget>[
                Icon(Icons.info, size: 30),
                Icon(Icons.person, size: 30),
                Icon(Icons.campaign, size: 30),
              ],
              onTap: _onItemTapped),
        ),
      ),
    );
  }
}
