import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/api.dart';
import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/main.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:latlong2/latlong.dart' as latlng;

class RequestBlood extends StatefulWidget {
  const RequestBlood({Key? key}) : super(key: key);

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late String token1;
  var _selectedGenderValue;
  var _selectedBloodGroupValue;
  List<String> gender = ['Male', 'Female'];
  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });
  }

  @override
  void initState() {
    _getUserLocation();

    // TODO: implement initState
    super.initState();
    firebaseCloudMessagingListeners();
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      print("Token is " + token!);
      token1 = token;
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  // final TextEditingController _gender = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _hospitalName = TextEditingController();
  final TextEditingController _hospitalAddress = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  // final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _bloodAmount = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  final String _postTime = DateFormat.yMEd().add_jms().format(DateTime.now());

  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? value;

  Future sendNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )));
      }
    });

    final uri = Uri.parse("$rootUrl/bbms_api/fcmBloodRequest.php");
    var response = await http.post(uri, body: {
      "token": token1,
      "message":
          "There is an emergency blood request at ${_hospitalName.text},${_hospitalAddress.text} for $_selectedBloodGroupValue"
    });
    return json.decode(response.body);
  }

  Future requestBlood() async {
    var url = Uri.parse(postBloodRequestUrl);
    var response = await http.post(url, body: {
      "name": _name.text,
      "gender": _selectedGenderValue,
      "age": _age.text,
      "hospital_name": _hospitalName.text,
      "hospital_address": _hospitalAddress.text,
      "email": _email.text,
      "phone_number": _phoneNumber.text,
      "blood_group": _selectedBloodGroupValue,
      "blood_amount": _bloodAmount.text,
      "reason": _reason.text,
      "post_time": _postTime,
      "latitude": _userLocation!.latitude.toString(),
      "longitude": _userLocation!.longitude.toString(),
    });
    var data = await json.decode(response.body);
    print(data);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Blood Request submitted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(
          msg: "Blood request failed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Request Blood"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            nameTextField(),
            genderTextField(),
            ageTextField(),
            emailTextField(),
            hospitalNameFormField(),
            hospitalAddressFormField(),
            phoneTextField(),
            bloodGroupDropDownField(),
            bloodAmountTextField(),
            reasonTextField(),

            const SizedBox(
              height: 40,
            ),
            // ElevatedButton(onPressed: () {}, child: Text('Request for blood')),
            requestBloodBtn(),
          ],
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your name";
          }
          return null;
        },
        controller: _name,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.red,
          ),
          hintText: "Enter Your Name",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          }
          return null;
        },
        controller: _email,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.red,
          ),
          hintText: "Enter Your Email",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget ageTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your age";
          }
          return null;
        },
        controller: _age,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.numbers,
            color: Colors.red,
          ),
          hintText: "Enter Your Age",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget hospitalNameFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your hospital name";
          }
          return null;
        },
        controller: _hospitalName,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.local_hospital,
            color: Colors.red,
          ),
          hintText: "Enter your hospital name ",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget hospitalAddressFormField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        // keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your hospital address";
          }
          return null;
        },
        controller: _hospitalAddress,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
          ),
          hintText: "Enter your hospital address ",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your phone number";
          }
          return null;
        },
        controller: _phoneNumber,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: Colors.red,
          ),
          hintText: "Enter your phone number",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget genderTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffEEEEEE),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return "Please specify your gender";
          }
          return null;
        },
        value: _selectedGenderValue,
        hint: Text(
          'Choose your gender',
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedGenderValue = value;
          });
        },
        onSaved: (value) {
          setState(() {
            _selectedGenderValue = value;
          });
        },
        items: gender.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bloodGroupDropDownField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffEEEEEE),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return "Please select one";
          }
          return null;
        },
        value: _selectedBloodGroupValue,
        hint: Text(
          'Choose your blood group',
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedBloodGroupValue = value;
          });
        },
        onSaved: (value) {
          setState(() {
            _selectedBloodGroupValue = value;
          });
        },
        items: bloodGroup.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bloodAmountTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter required blood amount";
          }
          return null;
        },
        controller: _bloodAmount,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.bloodtype_sharp,
            color: Colors.red,
          ),
          hintText: "Enter your required blood amount",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget reasonTextField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please give a reason for your request";
          }
          return null;
        },
        controller: _reason,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: Icon(
            Icons.comment,
            color: Colors.red,
          ),
          hintText: "Enter your reason",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget requestBloodBtn() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          requestBlood();

          // showNotification();
          sendNotification();
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: Text(
          "Request for blood",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildBloodGroupItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item),
    );
