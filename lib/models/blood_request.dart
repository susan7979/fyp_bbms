import 'dart:convert';

import 'package:flutter/material.dart';

List<BloodRequest> bloodRequestFromJson(String str) => List<BloodRequest>.from(
    json.decode(str).map((x) => BloodRequest.fromJson(x)));

String bloodRequestToJson(List<BloodRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BloodRequest {
  BloodRequest({
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
    required this.postTime,
  });

  String name;
  String gender;
  String age;
  String hospitalName;
  String hospitalAddress;
  String email;
  String phoneNumber;
  String bloodGroup;
  String bloodAmount;
  String reason;
  String postTime;

  factory BloodRequest.fromJson(Map<String, dynamic> json) => BloodRequest(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        hospitalName: json["hospital_name"],
        hospitalAddress: json["hospital_address"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        bloodGroup: json["blood_group"],
        bloodAmount: json["blood_amount"],
        reason: json["reason"],
        postTime: json["post_time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "hospital_name": hospitalName,
        "hospital_address": hospitalAddress,
        "email": email,
        "phone_number": phoneNumber,
        "blood_group": bloodGroup,
        "blood_amount": bloodAmount,
        "reason": reason,
        "post_time": postTime,
      };
}
