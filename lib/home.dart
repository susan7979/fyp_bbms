import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/blood_request/blood_request_card.dart';
import 'package:fyp_bbms/blood_request/blood_request_details.dart';
import 'package:fyp_bbms/donation_campaigns/donation_campaigns_card.dart';
import 'package:fyp_bbms/donation_campaigns/donation_campaigns_details.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_card.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_details.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:fyp_bbms/models/model_donation_campaigns.dart';
import 'package:fyp_bbms/nav/post_campaigns.dart';
import 'package:fyp_bbms/nav/register_donor.dart';
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
  List<DonationCampaigns> filteredCampaignData = [];
  List<DonationCampaigns> _donationCampaign = [];
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

  Future<List<DonationCampaigns>> getAllCampaigns() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.1.79/flutter-login-signup/donation_campaigns.php"));
      if (response.statusCode == 200) {
        final List<DonationCampaigns> _donationCampaings =
            donationCampaignsFromJson(response.body);
        return _donationCampaings;
      } else {
        return <DonationCampaigns>[];
      }
    } catch (e) {
      return <DonationCampaigns>[];
    }
    // setState(() {
    //   _bloodRequest = json.decode(response.body);
    // });
    // // print(_bloodRequest);
    // return _bloodRequest;
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
    getAllCampaigns().then((donationCampaign) {
      setState(() {
        _donationCampaign = filteredCampaignData = donationCampaign;
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
      filteredCampaignData = _donationCampaign
          .where((element) =>
              element.hostName.toLowerCase().contains(value.toLowerCase()))
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

  getCampaignsDetails(String hostName, String campaignLocation, String email,
      String phoneNumber, String campaignDescription, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DonationCampaignsDetails(
                  hostName: hostName,
                  campaignLocation: campaignLocation,
                  email: email,
                  phoneNumber: phoneNumber,
                  campaignDescription: campaignDescription,
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
      ListView.builder(
          itemCount:
              filteredCampaignData.isEmpty ? 0 : filteredCampaignData.length,
          itemBuilder: (context, index) {
            DonationCampaigns donationCampaign = filteredCampaignData[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  getCampaignsDetails(
                      donationCampaign.hostName,
                      donationCampaign.campaignLocation,
                      donationCampaign.email,
                      donationCampaign.phoneNumber,
                      donationCampaign.campaignDescription,
                      context);
                },
                child:
                    DonationCampaignsCard(donationCampaign: donationCampaign),
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
                      MaterialPageRoute(builder: (context) => RegisterDonor()));
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
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.hospital),
              label: 'Donation Campaigns',
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
