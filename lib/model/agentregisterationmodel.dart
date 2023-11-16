// To parse this JSON data, do
//
//     final agentregisterationmodel = agentregisterationmodelFromJson(jsonString);

import 'dart:convert';

Agentregisterationmodel agentregisterationmodelFromJson(String str) => Agentregisterationmodel.fromJson(json.decode(str));

String agentregisterationmodelToJson(Agentregisterationmodel data) => json.encode(data.toJson());

class Agentregisterationmodel {
    Agentregisterationmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Agentregisterationmodel.fromJson(Map<String, dynamic> json) => Agentregisterationmodel(
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
    });

    String status;
    int userId;
    int roleId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        userId: json["userId"] == null ? null : json["userId"],
        roleId: json["roleId"] == null ? null : json["roleId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "userId": userId == null ? null : userId,
        "roleId": roleId == null ? null : roleId,
    };
}
