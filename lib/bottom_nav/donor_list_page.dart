import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../api.dart';
import '../donor_registration/donor_registration_card.dart';
import '../donor_registration/donor_registration_details.dart';
import '../misc/refresh_widget.dart';
import '../models/donor_register.dart';
import 'package:http/http.dart' as http;

import '../nav/navigation_drawer.dart';
import '../providers/donor_register_provider.dart';

class DonorListPage extends StatefulWidget {
  const DonorListPage({Key? key}) : super(key: key);

  @override
  State<DonorListPage> createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {
  final GlobalKey<RefreshIndicatorState> keyRefresh =
      GlobalKey<RefreshIndicatorState>();
  List<DonorRegister> _donorRegister = [];
  List<DonorRegister> filteredDonorData = [];
  bool isSearching = false;

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

  void initState() {
    // TODO: implement initState
    super.initState();

    getAllDonorRegister();

    getAllDonorRegister().then((donorRegister) {
      setState(() {
        _donorRegister = filteredDonorData = donorRegister;
      });
    });
  }

  void _filterDonors(value) {
    setState(() {
      filteredDonorData = _donorRegister
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
                'Donors List',
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            : TextField(
                onChanged: (value) {
                  _filterDonors(value);
                },
                decoration: InputDecoration(
                    hintText: "Search donors by blood group",
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
      body: filteredDonorData.isEmpty
          ? Center(child: CircularProgressIndicator.adaptive())
          : RefreshWidget(
              onRefresh:
                  context.watch<DonorRegisterProvider>().getAllDonorRegister,
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
                          Get.to(
                              () => DonorRegistrationDetails(
                                    donorRegister: donorRegister,
                                  ),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child:
                            DonorRegistrationCard(donorRegister: donorRegister),
                      ),
                    );
                  }),
            ),
    );
  }
}
