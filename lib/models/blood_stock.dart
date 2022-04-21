import 'dart:convert';

List<BloodStockModel> bloodStockModelFromJson(String str) =>
    List<BloodStockModel>.from(
        json.decode(str).map((x) => BloodStockModel.fromJson(x)));

String bloodStockModelToJson(List<BloodStockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BloodStockModel {
  BloodStockModel({
    required this.bloodGroup,
    required this.numberOfPint,
    required this.lastUpdatedDate,
  });

  String bloodGroup;
  String numberOfPint;
  DateTime lastUpdatedDate;

  factory BloodStockModel.fromJson(Map<String, dynamic> json) =>
      BloodStockModel(
        bloodGroup: json["blood_group"],
        numberOfPint: json["number_of_pint"],
        lastUpdatedDate: DateTime.parse(json["last_updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "blood_group": bloodGroup,
        "number_of_pint": numberOfPint,
        "last_updated_date": lastUpdatedDate.toIso8601String(),
      };
}
