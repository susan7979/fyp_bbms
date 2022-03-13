import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<DonorRegister> donorRegisterFromJson(String str) =>
    List<DonorRegister>.from(
        json.decode(str).map((x) => DonorRegister.fromJson(x)));

String donorRegisterToJson(List<DonorRegister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DonorRegister {
  DonorRegister({
    required this.name,
    required this.gender,
    required this.age,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
  });

  String name;
  String gender;
  String age;
  String address;
  String email;
  String phoneNumber;
  String bloodGroup;

  factory DonorRegister.fromJson(Map<String, dynamic> json) => DonorRegister(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        bloodGroup: json["blood_group"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "address": address,
        "email": email,
        "phone_number": phoneNumber,
        "blood_group": bloodGroup,
      };
}
