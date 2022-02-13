import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/models/blood_request.dart';

class DonatePage extends StatefulWidget {
  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  Future registerDonor() async {
    var url = Uri.parse(
        "http://192.168.1.79/flutter-login-signup/user_dashboard/register_donor.php");
    var response = await http.post(url, body: {
      "name": _name.text,
      "gender": _gender.text,
      "age": _age.text,
      "address": _address.text,
      "email": _email.text,
      "phone_number": _phoneNumber.text,
      "blood_group": _bloodGroup.text,
      "blood_amount": _amount.text,
    });
    var data = await json.decode(response.body);
    print(data);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Donor Registration Succesfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Registration failed!",
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
      appBar: AppBar(
        title: Text(
          'Register for Donating Blood',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: "Name"),
          ),
          TextFormField(
            controller: _gender,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your gender',
                labelText: "Gender"),
          ),
          TextFormField(
            controller: _age,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.person),
                hintText: 'Enter your age',
                labelText: "Age"),
          ),
          TextFormField(
            controller: _address,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.home),
                hintText: 'Enter your address',
                labelText: "Address"),
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.email),
                hintText: 'Enter your email',
                labelText: "Email"),
          ),
          TextFormField(
            controller: _phoneNumber,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.phone),
                hintText: 'Enter your phone number',
                labelText: "Phone Number"),
          ),
          TextFormField(
            controller: _bloodGroup,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.bloodtype_rounded),
                hintText: 'Enter your blood group',
                labelText: "Blood Group"),
          ),
          TextFormField(
            controller: _amount,
            decoration: const InputDecoration(
                // contentPadding: EdgeInsets.all(8),
                icon: Icon(Icons.bloodtype),
                hintText: 'Enter your desired amount to donate',
                labelText: "Amount"),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                registerDonor();
              },
              child: Text('Register for donating'))
        ],
      ),
    );
  }
}
