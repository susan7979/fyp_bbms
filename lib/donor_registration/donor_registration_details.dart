import 'package:flutter/material.dart';

class DonorRegistrationDetails extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String address;
  final String email;
  final String phoneNumber;
  final String bloodGroup;
  final String bloodAmount;

  const DonorRegistrationDetails({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.bloodAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donor Details',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: Column(
        children: [
          Text(name),
          Text(gender),
          Text(age),
          Text(address),
          Text(email),
          Text(phoneNumber),
          Text(bloodGroup),
          Text(bloodAmount),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mail,
                  color: Colors.red,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.green,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
