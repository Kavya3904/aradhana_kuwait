// To parse this JSON data, do
//
//     final profileditpostmodel = profileditpostmodelFromJson(jsonString);

import 'dart:convert';

Profileditpostmodel profileditpostmodelFromJson(String str) => Profileditpostmodel.fromJson(json.decode(str));

String profileditpostmodelToJson(Profileditpostmodel data) => json.encode(data.toJson());

class Profileditpostmodel {
    Profileditpostmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Profileditpostmodel.fromJson(Map<String, dynamic> json) => Profileditpostmodel(
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
    });

    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
    };
}
