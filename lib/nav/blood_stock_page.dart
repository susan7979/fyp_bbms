import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_bbms/models/blood_stock.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class BloodStockPage extends StatefulWidget {
  const BloodStockPage({Key? key}) : super(key: key);

  @override
  State<BloodStockPage> createState() => _BloodStockPageState();
}

class _BloodStockPageState extends State<BloodStockPage> {
  List<BloodStockModel> _bloodStock = [];
  Future<List<BloodStockModel>> getBloodStock() async {
    var response = await http.get(Uri.parse(bloodStockUrl));
    if (response.statusCode == 200) {
      final List<BloodStockModel> _bloodStock =
          bloodStockModelFromJson(response.body);
      return _bloodStock;
    } else {
      return <BloodStockModel>[];
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    getBloodStock();

    getBloodStock().then((bloodStock) {
      setState(() {
        _bloodStock = bloodStock;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Stocks",
          style: TextStyle(color: Colors.red[800]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
          itemCount: _bloodStock.length,
          itemBuilder: (context, index) {
            BloodStockModel bloodStock = _bloodStock[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: Colors.black45,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 152, 145),
                    Color.fromARGB(255, 245, 70, 58)
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.tint),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bloodStock.bloodGroup,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  bloodStock.numberOfPint + ' pints',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Last Updated Date: ' +
                                bloodStock.lastUpdatedDate.toString()),
                            // onTap: () {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) =>
                            //           NearbyOrganizationDetails(
                            //             nearbyOrganizationsModel:
                            //                 nearbyOrganizationsModel,
                            //           )));
                            // },
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
