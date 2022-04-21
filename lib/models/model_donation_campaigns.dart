import 'dart:convert';

List<DonationCampaigns> donationCampaignsFromJson(String str) =>
    List<DonationCampaigns>.from(
        json.decode(str).map((x) => DonationCampaigns.fromJson(x)));

String donationCampaignsToJson(List<DonationCampaigns> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DonationCampaigns {
  DonationCampaigns({
    required this.hostName,
    required this.campaignLocation,
    required this.campaignDate,
    required this.email,
    required this.phoneNumber,
    required this.campaignDescription,
  });

  String hostName;
  String campaignLocation;
  String campaignDate;
  String email;
  String phoneNumber;
  String campaignDescription;

  factory DonationCampaigns.fromJson(Map<String, dynamic> json) =>
      DonationCampaigns(
        hostName: json["host_name"],
        campaignLocation: json["campaign_location"],
        campaignDate: json["campaign_date"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        campaignDescription: json["campaign_description"],
      );

  Map<String, dynamic> toJson() => {
        "host_name": hostName,
        "campaign_location": campaignLocation,
        "campaign_date": campaignDate,
        "email": email,
        "phone_number": phoneNumber,
        "campaign_description": campaignDescription,
      };
}
