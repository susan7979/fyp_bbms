import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api.dart';
import '../blood_request/blood_request_card.dart';
import '../blood_request/blood_request_details.dart';
import '../models/blood_request.dart';
import 'package:http/http.dart' as http;

import '../nav/navigation_drawer.dart';

class BloodRequestPage extends StatefulWidget {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  State<BloodRequestPage> createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage> {
  List<BloodRequest> _bloodRequest = [];
  List<BloodRequest> filteredReqData = [];
  bool isSearching = false;

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
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBloodRequest();

    getAllBloodRequest().then((bloodRequest) {
      setState(() {
        _bloodRequest = filteredReqData = bloodRequest;
      });
    });
  }

  void _filterBloodReq(value) {
    setState(() {
      filteredReqData = _bloodRequest
          .where((element) =>
              element.bloodGroup.toLowerCase().contains(value.toLowerCase()))
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
                'Blood Requests',
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            : TextField(
                onChanged: (value) {
                  _filterBloodReq(value);
                },
                decoration: InputDecoration(
                    hintText: "Search requests by blood group",
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
                      filteredReqData = _bloodRequest;
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
      body: filteredReqData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
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
                              Get.to(
                                  () => BloodRequestDetails(
                                        bloodRequest: bloodRequest,
                                      ),
                                  transition: Transition.rightToLeftWithFade);
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
    );
  }
}
