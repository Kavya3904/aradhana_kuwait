// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
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
    this.islogin,
    this.token,
    this.userName,
    this.userId,
    this.email,
    this.roleId,
          this.branchId,
    this.subscriptionList,
    this.referalId
  });

  String status;
  bool islogin;
  String token;
  String userName;
  int userId;
  String email;
    int branchId;
  int roleId;
  
  String referalId;
  List<SubscriptionList> subscriptionList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        islogin: json["islogin"] == null ? null : json["islogin"],
        token: json["token"] == null ? null : json["token"],
        userName: json["userName"] == null ? null : json["userName"],
        userId: json["userId"] == null ? null : json["userId"],
        email: json["Email"] == null ? null : json["Email"],
        roleId: json["roleId"] == null ? null : json["roleId"],
         branchId: json["branchId"] == null ? null : json["branchId"],
         referalId: json["referalId"] == null ? null : json["referalId"],
       
        subscriptionList: json["subscriptionList"] == null
            ? null
            : List<SubscriptionList>.from(json["subscriptionList"]
                .map((x) => SubscriptionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "islogin": islogin == null ? null : islogin,
        "token": token == null ? null : token,
        "userName": userName == null ? null : userName,
        "userId": userId == null ? null : userId,
        "Email": email == null ? null : email,
        "roleId": roleId == null ? null : roleId,
         "referalId": referalId == null ? null : referalId,
               "branchId": branchId == null ? null : branchId,
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
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  DateTime startDate;
  dynamic endDate;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

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
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "StartDate": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "EndDate": endDate,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
