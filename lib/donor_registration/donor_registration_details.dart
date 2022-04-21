import 'package:flutter/material.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorRegistrationDetails extends StatelessWidget {
  final DonorRegister donorRegister;

  const DonorRegistrationDetails({Key? key, required this.donorRegister})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'Donor Details',
    //       style: TextStyle(color: Theme.of(context).primaryColor),
    //     ),
    //     iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    //     elevation: 0,
    //     backgroundColor: Colors.grey[50],
    //   ),
    //   body: Column(
    //     children: [

    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           IconButton(
    //             onPressed: () {},
    //             icon: Icon(
    //               Icons.mail,
    //               color: Colors.red,
    //               size: 35,
    //             ),
    //           ),
    //           IconButton(
    //             onPressed: () {},
    //             icon: Icon(
    //               Icons.call,
    //               color: Colors.green,
    //               size: 35,
    //             ),
    //           ),
    //           IconButton(
    //             onPressed: () {},
    //             icon: Icon(
    //               Icons.share,
    //               color: Colors.blue,
    //               size: 35,
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
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
            body: Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Material(
                        elevation: 0.0,
                        child: Container(
                          height: 180,
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3))
                              ],
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$rootUrl/bbms_api/images/${donorRegister.profileImage}"),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Container(
                        width: screenWidth - 30 - 170 - 20,
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),

                            // Text("Blood AmountRequired: $bloodAmount"),
                          ],
                        ),
                      )
                    ],
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
                        donorRegister.name,
                        style: TextStyle(fontSize: 23),
                      ),
                      Text("Age: ${donorRegister.age}"),
                      Text("Gender: ${donorRegister.gender}"),
                      Text("Address: ${donorRegister.address}"),
                      Text("Blood Group: ${donorRegister.bloodGroup}"),
                    ],
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
                                launch('mailto:${donorRegister.email}');
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
                                launch('tel:${donorRegister.phoneNumber}');
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
