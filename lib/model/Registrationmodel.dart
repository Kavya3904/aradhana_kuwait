// To parse this JSON data, do
//
//     final registrationmodel = registrationmodelFromJson(jsonString);

import 'dart:convert';

Registrationmodel registrationmodelFromJson(String str) => Registrationmodel.fromJson(json.decode(str));

String registrationmodelToJson(Registrationmodel data) => json.encode(data.toJson());

class Registrationmodel {
    Registrationmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Registrationmodel.fromJson(Map<String, dynamic> json) => Registrationmodel(
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
        this.userId,
        this.roleId,
        this.token,
    });

    String status;
    int userId;
    int roleId;
    String token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        userId: json["userId"] == null ? null : json["userId"],
        roleId: json["roleId"] == null ? null : json["roleId"],
        token: json["token"] == null ? null : json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "userId": userId == null ? null : userId,
        "roleId": roleId == null ? null : roleId,
        "token": token == null ? null : token,
    };
}
