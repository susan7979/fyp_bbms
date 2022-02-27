import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/blood_request/blood_request_card.dart';
import 'package:fyp_bbms/blood_request/blood_request_details.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_card.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_details.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:fyp_bbms/nav/donate_blood.dart';
import 'package:fyp_bbms/nav/navigation_drawer.dart';
import 'package:fyp_bbms/nav/request_blood.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BloodRequest> _bloodRequest = [];
  List<DonorRegister> _donorRegister = [];
  List<BloodRequest> filteredReqData = [];
  List<DonorRegister> filteredDonorData = [];
  bool _loading = true;
  bool isSearching = false;
  final isDialOpen = ValueNotifier(false);

  Future<List<BloodRequest>> getAllBloodRequest() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.1.79/flutter-login-signup/blood_requests.php"));
      if (response.statusCode == 200) {
        final List<BloodRequest> _bloodRequest =
            bloodRequestFromJson(response.body);
        return _bloodRequest;
      } else {
        return <BloodRequest>[];
      }
    } catch (e) {
      return <BloodRequest>[];
    }
    // setState(() {
    //   _bloodRequest = json.decode(response.body);
    // });
    // // print(_bloodRequest);
    // return _bloodRequest;
  }

  Future<List<DonorRegister>> getAllDonorRegister() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.1.79/flutter-login-signup/donor_register.php"));
      if (response.statusCode == 200) {
        final List<DonorRegister> _donorRegister =
            donorRegisterFromJson(response.body);
        return _donorRegister;
      }
      // print(_donorReg);
      return <DonorRegister>[];
    } catch (e) {
      return <DonorRegister>[];
      // TODO
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getAllBloodRequest().then((bloodRequest) {
      setState(() {
        _bloodRequest = filteredReqData = bloodRequest;
        _loading = false;
      });
    });
    getAllDonorRegister().then((donorRegister) {
      setState(() {
        _donorRegister = filteredDonorData = donorRegister;
        _loading = false;
      });
    });
  }

  void _filterPerson(value) {
    setState(() {
      filteredReqData = _bloodRequest
          .where((element) =>
              element.bloodGroup.toLowerCase().contains(value.toLowerCase()))
          .toList();
      filteredDonorData = _donorRegister
          .where((element) =>
              element.bloodGroup.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  getRequesterDetails(
      String name,
      String gender,
      String age,
      String hospitalName,
      String hospitalAddress,
      String email,
      String phoneNumber,
      String bloodGroup,
      String bloodAmount,
      String reason,
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BloodRequestDetails(
                  name: name,
                  gender: gender,
                  age: age,
                  hospitalName: hospitalName,
                  hospitalAddress: hospitalAddress,
                  email: email,
                  phoneNumber: phoneNumber,
                  bloodGroup: bloodGroup,
                  bloodAmount: bloodAmount,
                  reason: reason,
                )));
  }

  getDonorDetails(
      String name,
      String gender,
      String age,
      String address,
      String email,
      String phoneNumber,
      String bloodGroup,
      String bloodAmount,
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DonorRegistrationDetails(
                  name: name,
                  gender: gender,
                  age: age,
                  address: address,
                  email: email,
                  phoneNumber: phoneNumber,
                  bloodGroup: bloodGroup,
                  bloodAmount: bloodAmount,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ListView.builder(
          itemCount: filteredReqData.isEmpty ? 0 : filteredReqData.length,
          itemBuilder: (context, index) {
            BloodRequest bloodRequest = filteredReqData[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  getRequesterDetails(
                      bloodRequest.name,
                      bloodRequest.gender,
                      bloodRequest.age,
                      bloodRequest.hospitalName,
                      bloodRequest.hospitalAddress,
                      bloodRequest.email,
                      bloodRequest.phoneNumber,
                      bloodRequest.bloodGroup,
                      bloodRequest.bloodAmount,
                      bloodRequest.reason,
                      context);
                },
                child: BloodRequestCard(bloodRequest: bloodRequest),
              ),
            );
          }),
      ListView.builder(
          itemCount: filteredDonorData.isEmpty ? 0 : filteredDonorData.length,
          itemBuilder: (context, index) {
            DonorRegister donorRegister = filteredDonorData[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  getDonorDetails(
                      donorRegister.name,
                      donorRegister.gender,
                      donorRegister.age,
                      donorRegister.address,
                      donorRegister.email,
                      donorRegister.phoneNumber,
                      donorRegister.bloodGroup,
                      donorRegister.bloodAmount,
                      context);
                },
                child: DonorRegistrationCard(donorRegister: donorRegister),
              ),
            );
          }),
    ];
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
        appBar: AppBar(
          title: !isSearching
              ? Text(
                  'BloodSource',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              : TextField(
                  onChanged: (value) {
                    _filterPerson(value);
                  },
                  decoration: InputDecoration(
                      hintText: "Search ",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(Icons.search,
                          color: Theme.of(context).primaryColor)),
                ),
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        filteredReqData = _bloodRequest;
                        filteredDonorData = _donorRegister;
                      });
                    },
                    icon: Icon(Icons.cancel),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: Icon(Icons.search),
                  )
          ],
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          elevation: 0,
          backgroundColor: Colors.grey[50],
        ),
        drawer: NavigationDrawer(),
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.red,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          openCloseDial: isDialOpen,
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
                label: 'Register as donor',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DonatePage()));
                }),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.exclamationCircle),
              label: 'Blood Request',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.list),
              label: 'Donors List',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
