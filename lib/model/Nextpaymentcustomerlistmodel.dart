// To parse this JSON data, do
//
//     final nextpaymentcustomerlistmodel = nextpaymentcustomerlistmodelFromJson(jsonString);

import 'dart:convert';

Nextpaymentcustomerlistmodel nextpaymentcustomerlistmodelFromJson(String str) =>
    Nextpaymentcustomerlistmodel.fromJson(json.decode(str));

String nextpaymentcustomerlistmodelToJson(Nextpaymentcustomerlistmodel data) =>
    json.encode(data.toJson());

class Nextpaymentcustomerlistmodel {
  Nextpaymentcustomerlistmodel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory Nextpaymentcustomerlistmodel.fromJson(Map<String, dynamic> json) =>
      Nextpaymentcustomerlistmodel(
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
    this.customerList,
  });

  String status;
  List<CustomerList> customerList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        customerList: json["CustomerList"] == null
            ? null
            : List<CustomerList>.from(
                json["CustomerList"].map((x) => CustomerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "CustomerList": customerList == null
            ? null
            : List<dynamic>.from(customerList.map((x) => x.toJson())),
      };
}

class CustomerList {
  CustomerList({
    this.userId,
    this.name,
    this.phone,
    this.subscriptionId,
    this.registrationNumber
  });

  int userId;
  String name;
  String phone;
  int subscriptionId;
  String registrationNumber;

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
      userId: json["UserId"] == null ? null : json["UserId"],
      name: json["name"] == null ? null : json["name"],
      phone: json["phone"] == null ? null : json["phone"],
      subscriptionId:
          json["subscriptionId"] == null ? null : json["subscriptionId"],
      registrationNumber: json["registrationNumber"] == null
          ? null
          : json["registrationNumber"]);

  Map<String, dynamic> toJson() => {
        "UserId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "registrationNumber":registrationNumber=null ? null :registrationNumber
      };
}
