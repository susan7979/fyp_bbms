import 'package:flutter/material.dart';

import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';
import 'package:fyp_bbms/models/nearby_organization_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyOrganizationDetails extends StatelessWidget {
  final NearbyOrganizationsModel nearbyOrganizationsModel;

  const NearbyOrganizationDetails(
      {Key? key, required this.nearbyOrganizationsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: CustomAppBar(title: name),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: FloatingActionButton.extended(
    //     backgroundColor: Colors.red.shade800,
    //     icon: const Icon(Icons.payment),
    //     label: Text('Donate'),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => KhaltiPaymentApp(),
    //       ));
    //     },
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Text(
    //               name,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           color: Colors.red[200],
    //         ),
    //         Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Text(
    //               establishedDate,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           color: Colors.red[400],
    //         ),
    //         Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Text(
    //               location,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           color: Colors.red[400],
    //         ),
    //         Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Text(
    //               email,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           color: Colors.red[400],
    //         ),
    //         Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Text(
    //               phoneNumber,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           color: Colors.red[400],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => KhaltiPaymentApp(),
                ));
              },
            ),
            body: Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(
                        //     padding: EdgeInsets.zero,
                        //     constraints: BoxConstraints(),
                        //     icon: Icon(Icons.arrow_back_ios,
                        //         color: Color(0xFF363f93)),
                        //     onPressed: () => Navigator.pop(context))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Material(
                          elevation: 0.0,
                          child: Container(
                            height: 180,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                              // image: DecorationImage(
                              //   image: NetworkImage(
                              //     "http://mark.dbestech.com/uploads/"+this.widget.articleInfo.img
                              //   ),
                              //   fit:BoxFit.fill
                              // )
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth - 30 - 180 - 20,
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Details: ",
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                      Text(
                        nearbyOrganizationsModel.name,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text("ESTD: ${nearbyOrganizationsModel.establishedDate}"),
                    ],
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
                            IconButton(
                                onPressed: () {
                                  launch(
                                      'mailto:${nearbyOrganizationsModel.email}');
                                },
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.red,
                                  size: 40,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  launch(
                                      'tel:${nearbyOrganizationsModel.phoneNumber}');
                                },
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                  size: 40,
                                )),
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
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    child: Text("Description"),
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
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
