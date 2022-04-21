import 'dart:convert';

import 'dart:ffi';

List<NearbyOrganizationsModel> nearbyOrganizationsModelFromJson(String str) =>
    List<NearbyOrganizationsModel>.from(
        json.decode(str).map((x) => NearbyOrganizationsModel.fromJson(x)));

String nearbyOrganizationsModelToJson(List<NearbyOrganizationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearbyOrganizationsModel {
  NearbyOrganizationsModel({
    required this.name,
    required this.establishedDate,
    required this.location,
    required this.email,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });

  String name;
  DateTime establishedDate;
  String location;
  String email;
  String phoneNumber;
  String latitude;
  String longitude;

  factory NearbyOrganizationsModel.fromJson(Map<String, dynamic> json) =>
      NearbyOrganizationsModel(
        name: json["name"],
        establishedDate: DateTime.parse(json["established_date"]),
        location: json["location"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "established_date":
            "${establishedDate.year.toString().padLeft(4, '0')}-${establishedDate.month.toString().padLeft(2, '0')}-${establishedDate.day.toString().padLeft(2, '0')}",
        "location": location,
        "email": email,
        "phone_number": phoneNumber,
        "latitude": latitude,
        "longitude": longitude,
      };
}
