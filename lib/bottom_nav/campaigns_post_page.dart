import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api.dart';
import '../donation_campaigns/donation_campaigns_card.dart';
import '../donation_campaigns/donation_campaigns_details.dart';
import '../models/model_donation_campaigns.dart';
import 'package:http/http.dart' as http;

import '../nav/navigation_drawer.dart';

class CampaignsPostPage extends StatefulWidget {
  const CampaignsPostPage({Key? key}) : super(key: key);

  @override
  State<CampaignsPostPage> createState() => _CampaignsPostPageState();
}

class _CampaignsPostPageState extends State<CampaignsPostPage> {
  List<DonationCampaigns> filteredCampaignData = [];
  List<DonationCampaigns> _donationCampaign = [];
  bool isSearching = false;

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

  void initState() {
    // TODO: implement initState
    super.initState();

    getAllCampaigns();

    getAllCampaigns().then((donationCampaign) {
      setState(() {
        _donationCampaign = filteredCampaignData = donationCampaign;
      });
    });
  }

  void _filterCampaigns(value) {
    setState(() {
      filteredCampaignData = _donationCampaign
          .where((element) =>
              element.hostName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return RotatedBox(
              quarterTurns: 1,
              child: IconButton(
                icon: Icon(
                  Icons.bar_chart_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
        title: !isSearching
            ? Text(
                'Donation Events',
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            : TextField(
                onChanged: (value) {
                  _filterCampaigns(value);
                },
                decoration: InputDecoration(
                    hintText: "Search campaigns by name",
                    hintStyle: TextStyle(color: Colors.red),
                    icon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor)),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      filteredCampaignData = _donationCampaign;
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
      body: filteredCampaignData.isEmpty
          ? Center(
              child: Image.asset('assets/images/notfound.png'),
            )
          : RefreshIndicator(
              onRefresh: () async {
                getAllCampaigns().then((donationCampaign) {
                  setState(() {
                    _donationCampaign = filteredCampaignData = donationCampaign;
                  });
                });
              },
              child: ListView.builder(
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
                          Get.to(
                              () => DonationCampaignsDetails(
                                    donationCampaign: donationCampaign,
                                  ),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child: DonationCampaignsCard(
                            donationCampaign: donationCampaign),
                      ),
                    );
                  }),
            ),
    );
  }
}
