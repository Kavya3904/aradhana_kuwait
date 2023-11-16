// To parse this JSON data, do
//
//     final agentcustomermodel = agentcustomermodelFromJson(jsonString);

import 'dart:convert';

Agentcustomermodel agentcustomermodelFromJson(String str) => Agentcustomermodel.fromJson(json.decode(str));

String agentcustomermodelToJson(Agentcustomermodel data) => json.encode(data.toJson());

class Agentcustomermodel {
    Agentcustomermodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Agentcustomermodel.fromJson(Map<String, dynamic> json) => Agentcustomermodel(
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
        this.versions,
        this.status,
        this.customerList,
    });

    Versions versions;
    String status;
    List<CustomerList> customerList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        versions: json["versions"] == null ? null : Versions.fromJson(json["versions"]),
        status: json["status"] == null ? null : json["status"],
        customerList: json["CustomerList"] == null ? null : List<CustomerList>.from(json["CustomerList"].map((x) => CustomerList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "versions": versions == null ? null : versions.toJson(),
        "status": status == null ? null : status,
        "CustomerList": customerList == null ? null : List<dynamic>.from(customerList.map((x) => x.toJson())),
    };
}

class CustomerList {
  CustomerList({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.dob,
    this.aCNumber,
    this.adhaarcard,
    this.pancard,
    this.nominee,
    this.nomineeRelation,
    this.pincode,
    this.district,
    this.state,
    this.country,
    this.image,
    this.referalId,
    this.point,
    this.userType,
    this.agentId,
    this.createdAt,
    this.updatedAt,
    this.registrationNumber
  });

  int id;
  int userId;
  String name;
  String email;
  String address;
  String phone;
  DateTime dob;
  String aCNumber;
  String adhaarcard;
  String pancard;
  String nominee;
  String nomineeRelation;
  String pincode;
  int district;
  int state;
  int country;
  dynamic image;
  String referalId;
  String point;
  int userType;
  int agentId;
  DateTime createdAt;
  DateTime updatedAt;
  String registrationNumber;

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        registrationNumber:json["registrationNumber"] == null ? null : json["registrationNumber"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        aCNumber: json["a_c_number"] == null ? null : json["a_c_number"],
        adhaarcard: json["adhaarcard"] == null ? null : json["adhaarcard"],
        pancard: json["pancard"] == null ? null : json["pancard"],
        nominee: json["nominee"] == null ? null : json["nominee"],
        nomineeRelation:
            json["nominee_relation"] == null ? null : json["nominee_relation"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        district: json["district"] == null ? null : json["district"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        image: json["image"],
        referalId: json["referalId"] == null ? null : json["referalId"],
        point: json["point"] == null ? null : json["point"],
        userType: json["userType"] == null ? null : json["userType"],
        agentId: json["agentId"] == null ? null : json["agentId"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "registrationNumber":registrationNumber== null ? null : registrationNumber,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "a_c_number": aCNumber == null ? null : aCNumber,
        "adhaarcard": adhaarcard == null ? null : adhaarcard,
        "pancard": pancard == null ? null : pancard,
        "nominee": nominee == null ? null : nominee,
        "nominee_relation": nomineeRelation == null ? null : nomineeRelation,
        "pincode": pincode == null ? null : pincode,
        "district": district == null ? null : district,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "image": image,
        "referalId": referalId == null ? null : referalId,
        "point": point == null ? null : point,
        "userType": userType == null ? null : userType,
        "agentId": agentId == null ? null : agentId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
class Versions {
    Versions({
        this.android,
        this.ios,
    });

    int android;
    int ios;

    factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        android: json["android"] == null ? null : json["android"],
        ios: json["ios"] == null ? null : json["ios"],
    );

    Map<String, dynamic> toJson() => {
        "android": android == null ? null : android,
        "ios": ios == null ? null : ios,
    };
}
