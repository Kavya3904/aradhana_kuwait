// To parse this JSON data, do
//
//     final subscriptionlistmodel = subscriptionlistmodelFromJson(jsonString);

import 'dart:convert';

Subscriptionlistmodel subscriptionlistmodelFromJson(String str) =>
    Subscriptionlistmodel.fromJson(json.decode(str));

String subscriptionlistmodelToJson(Subscriptionlistmodel data) =>
    json.encode(data.toJson());

class Subscriptionlistmodel {
  Subscriptionlistmodel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory Subscriptionlistmodel.fromJson(Map<String, dynamic> json) =>
      Subscriptionlistmodel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.status,
    this.subscriptionList,
  });

  String status;
  List<SubscriptionList> subscriptionList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        subscriptionList: json["subscriptionList"] == null
            ? null
            : List<SubscriptionList>.from(json["subscriptionList"]
                .map((x) => SubscriptionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "subscriptionList": subscriptionList == null
            ? null
            : List<dynamic>.from(subscriptionList.map((x) => x.toJson())),
      };
}

class SubscriptionList {
  SubscriptionList({
    this.id,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.startDate,
    this.endDate,
    this.status,
    this.schemeName,
    this.schemAmount,
    this.amountTo,
    this.subscriptionType,
    this.redeemtype,
  });

  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  DateTime startDate;
  dynamic endDate;
  int status;
  String schemeName;
  String schemAmount;
  String amountTo;
  int subscriptionType;
  int redeemtype;

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      SubscriptionList(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId:
            json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        startDate: json["StartDate"] == null
            ? null
            : DateTime.parse(json["StartDate"]),
        endDate: json["EndDate"],
        status: json["status"] == null ? null : json["status"],
        schemeName: json["schemeName"] == null ? null : json["schemeName"],
        schemAmount: json["schem_amount"] == null ? null : json["schem_amount"],
        amountTo: json["amount_to"] == null ? null : json["amount_to"],
        subscriptionType: json["subscription_type"] == null
            ? null
            : json["subscription_type"],

redeemtype:json["redeem_type"] == null
            ? null
            : json["redeem_type"],

      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "StartDate": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "EndDate": endDate,
        "status": status == null ? null : status,
        "schemeName": schemeName == null ? null : schemeName,
        "schem_amount": schemAmount == null ? null : schemAmount,
        "amount_to": amountTo == null ? null : amountTo,
        "subscription_type": subscriptionType == null ? null : subscriptionType,
      };
}
