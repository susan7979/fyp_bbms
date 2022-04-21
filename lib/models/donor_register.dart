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
    required this.donationEligibility,
    required this.profileImage,
  });

  String name;
  String gender;
  String age;
  String address;
  String email;
  String phoneNumber;
  String bloodGroup;
  String donationEligibility;
  String profileImage;

  factory DonorRegister.fromJson(Map<String, dynamic> json) => DonorRegister(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        address: json["address"],
        email: json["username"],
        phoneNumber: json["phone_number"],
        bloodGroup: json["blood_group"],
        donationEligibility: json["donation_eligibility"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "address": address,
        "username": email,
        "phone_number": phoneNumber,
        "blood_group": bloodGroup,
        "donation_eligibility": donationEligibility,
        "profile_image": profileImage,
      };
}
