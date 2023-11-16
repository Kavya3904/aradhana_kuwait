// To parse this JSON data, do
//
//     final schemeaddmodel = schemeaddmodelFromJson(jsonString);

import 'dart:convert';

Schemeaddmodel schemeaddmodelFromJson(String str) =>
    Schemeaddmodel.fromJson(json.decode(str));

String schemeaddmodelToJson(Schemeaddmodel data) => json.encode(data.toJson());

class Schemeaddmodel {
  bool success;
  String message;
  Data data;

  Schemeaddmodel({
    this.success,
    this.message,
    this.data,
  });

  factory Schemeaddmodel.fromJson(Map<String, dynamic> json) => Schemeaddmodel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String status;
  int subscriptionId;

  Data({
    this.status,
    this.subscriptionId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        subscriptionId: json["subscriptionId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subscriptionId": subscriptionId,
      };
}
