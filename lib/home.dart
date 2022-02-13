import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_bbms/blood_request_details.dart';
import 'package:fyp_bbms/donor_registration_details.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:fyp_bbms/navigation_drawer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BloodRequest> _bloodRequest = [];
  List<DonorRegister> _donorRegister = [];
  bool _loading = true;

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
        _bloodRequest = bloodRequest;
        _loading = false;
      });
    });
    getAllDonorRegister().then((donorRegister) {
      setState(() {
        _donorRegister = donorRegister;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: ListView.builder(
            itemCount: _bloodRequest.isEmpty ? 0 : _bloodRequest.length,
            itemBuilder: (context, index) {
              BloodRequest bloodRequest = _bloodRequest[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 12,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BloodRequestDetails()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(bloodRequest.name),
                            subtitle: Text(bloodRequest.bloodGroup),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Contact Patient'),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Location'),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      ListView.builder(
          itemCount: _donorRegister.isEmpty ? 0 : _donorRegister.length,
          itemBuilder: (context, index) {
            DonorRegister donorRegister = _donorRegister[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DonorRegistrationDetails()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(donorRegister.name),
                        subtitle: Text(donorRegister.bloodGroup),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Reach out to donor'),
                            onPressed: () {/* ... */},
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Location'),
                            onPressed: () {/* ... */},
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('BloodSource'),
      ),
      drawer: NavigationDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Blood Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Donor Registration',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
