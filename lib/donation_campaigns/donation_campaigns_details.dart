import 'package:flutter/material.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';
import 'package:fyp_bbms/models/model_donation_campaigns.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationCampaignsDetails extends StatelessWidget {
  final DonationCampaigns donationCampaign;

  const DonationCampaignsDetails({Key? key, required this.donationCampaign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.red.shade800,
              icon: const Icon(Icons.payment),
              label: Text('Donate'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => KhaltiPaymentApp(),
                // ));
              },
            ),
            body: Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      children: [
                        // Material(
                        //   elevation: 0.0,
                        //   child: Container(
                        //     height: 180,
                        //     width: 150,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             color: Colors.grey.withOpacity(0.5),
                        //             spreadRadius: 5,
                        //             blurRadius: 7,
                        //             offset: Offset(0, 3))
                        //       ],
                        //       // image: DecorationImage(
                        //       //   image: NetworkImage(
                        //       //     "http://mark.dbestech.com/uploads/"+this.widget.articleInfo.img
                        //       //   ),
                        //       //   fit:BoxFit.fill
                        //       // )
                        //     ),
                        //   ),
                        // ),
                        Container(
                          width: screenWidth - 30 - 100 - 20,
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Details: ",
                                style:
                                    TextStyle(fontSize: 24, color: Colors.red),
                              ),
                              Text(
                                donationCampaign.hostName,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                  "Campaign Location: ${donationCampaign.campaignLocation}"),
                              Text(
                                  "Campaign Date: ${donationCampaign.campaignDate}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                launch('mailto:${donationCampaign.email}');
                              },
                              child: Icon(
                                Icons.mail,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Mail"),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                launch('tel:${donationCampaign.phoneNumber}');
                              },
                              child: Icon(
                                Icons.phone,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                            Text("Call now")
                          ],
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: <Widget>[
                        //     IconButton(
                        //         onPressed: () {
                        //           launch('mailto:$email');
                        //         },
                        //         icon: Icon(
                        //           Icons.mail,
                        //           color: Colors.red,
                        //           size: 40,
                        //         )),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Campaign description: ",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                  Text('asd'),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    child: Text(donationCampaign.campaignDescription),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBooks()));
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.only(right: 20),
                  //     child: Row(
                  //       children: [
                  //         Text("asas"),
                  //         Expanded(child: Container()),
                  //         IconButton(
                  //             icon: Icon(Icons.arrow_forward_ios),
                  //             onPressed: null)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
