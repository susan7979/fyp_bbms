import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/blood_request/blood_request_card.dart';
import 'package:fyp_bbms/blood_request/blood_request_details.dart';
import 'package:fyp_bbms/donation_campaigns/donation_campaigns_card.dart';
import 'package:fyp_bbms/donation_campaigns/donation_campaigns_details.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_card.dart';
import 'package:fyp_bbms/donor_registration/donor_registration_details.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/misc/refresh_widget.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:fyp_bbms/models/model_donation_campaigns.dart';
// import 'package:fyp_bbms/models/user.dart';
import 'package:fyp_bbms/nav/post_campaigns.dart';
import 'package:fyp_bbms/nav/register_donor.dart';
import 'package:fyp_bbms/nav/navigation_drawer.dart';
import 'package:fyp_bbms/nav/request_blood.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> keyRefresh =
      new GlobalKey<RefreshIndicatorState>();
  List<BloodRequest> _bloodRequest = [];
  List<AuthProvider> _user = [];
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
      var response = await http.get(Uri.parse(getAllBloodRequestUrl));
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
    await Future.delayed(Duration(milliseconds: 400));
    try {
      var response = await http.get(Uri.parse(getAllDonorUrl));
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

  // Future<List<User>> getUser() async {
  //   await Future.delayed(Duration(milliseconds: 400));
  //   try {
  //     var response = await http.get(Uri.parse(
  //         "http://192.168.1.79/flutter-login-signup/user_details.php"));
  //     if (response.statusCode == 200) {
  //       final List<Users> _user = userFromJson(response.body);
  //       return _user;
  //     }
  //     print(_user);
  //     // print(_donorReg);
  //     return <User>[];
  //   } catch (e) {
  //     return <User>[];
  //     // TODO
  //   }
  // }

  Future<List<DonationCampaigns>> getAllCampaigns() async {
    try {
      var response = await http.get(Uri.parse(getAllCampaignsUrl));
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
    getAllBloodRequest();
    getAllDonorRegister();
    getAllCampaigns();

    getAllBloodRequest().then((bloodRequest) {
      setState(() {
        _bloodRequest = filteredReqData = bloodRequest;
      });
    });
    getAllDonorRegister().then((donorRegister) {
      setState(() {
        _donorRegister = filteredDonorData = donorRegister;
      });
    });
    getAllCampaigns().then((donationCampaign) {
      setState(() {
        _donationCampaign = filteredCampaignData = donationCampaign;
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      filteredReqData.isEmpty
          ? Center(
              child: Text('No matches found'),
            )
          : FutureBuilder(
              future: getAllBloodRequest(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount:
                          filteredReqData.isEmpty ? 0 : filteredReqData.length,
                      itemBuilder: (context, index) {
                        BloodRequest bloodRequest = filteredReqData[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BloodRequestDetails(
                                            bloodRequest: bloodRequest,
                                          )));
                            },
                            child: BloodRequestCard(bloodRequest: bloodRequest),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                }
              },
            ),
      filteredDonorData.isEmpty
          ? Center(
              child: Text('No matches found'),
            )
          : RefreshWidget(
              onRefresh: getAllDonorRegister,
              keyRefresh: keyRefresh,
              child: ListView.builder(
                  itemCount:
                      filteredDonorData.isEmpty ? 0 : filteredDonorData.length,
                  itemBuilder: (context, index) {
                    DonorRegister donorRegister = filteredDonorData[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DonorRegistrationDetails(
                                        donorRegister: donorRegister,
                                      )));
                        },
                        child:
                            DonorRegistrationCard(donorRegister: donorRegister),
                      ),
                    );
                  }),
            ),
      filteredCampaignData.isEmpty
          ? Center(
              child: Text('No matches found'),
            )
          : ListView.builder(
              itemCount: filteredCampaignData.isEmpty
                  ? 0
                  : filteredCampaignData.length,
              itemBuilder: (context, index) {
                DonationCampaigns donationCampaign =
                    filteredCampaignData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonationCampaignsDetails(
                                    donationCampaign: donationCampaign,
                                  )));
                    },
                    child: DonationCampaignsCard(
                        donationCampaign: donationCampaign),
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
