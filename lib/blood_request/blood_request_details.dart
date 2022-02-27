import 'package:flutter/material.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/misc/khalti_main.dart';

import 'package:fyp_bbms/models/blood_request.dart';

import 'package:url_launcher/url_launcher.dart';

class BloodRequestDetails extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String hospitalName;
  final String hospitalAddress;
  final String email;
  final String phoneNumber;
  final String bloodGroup;
  final String bloodAmount;
  final String reason;

  BloodRequestDetails({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.bloodAmount,
    required this.reason,
  }) : super(key: key);

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
                                name,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text("Age: $age"),
                              Text("Gender: $gender"),
                              Text("Hospital Name: $hospitalName"),
                              Text("Hospital Address: $hospitalAddress"),
                              Text("Blood Group: $bloodGroup"),
                              Text("Blood AmountRequired: $bloodAmount"),
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
                                launch('mailto:$email');
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
                                launch('tel:$phoneNumber');
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Reason for blood Request",
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    child: Text(reason),
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
