// To parse this JSON data, do
//
//     final paymentmodel = paymentmodelFromJson(jsonString);

import 'dart:convert';

Paymentmodel paymentmodelFromJson(String str) => Paymentmodel.fromJson(json.decode(str));

String paymentmodelToJson(Paymentmodel data) => json.encode(data.toJson());

class Paymentmodel {
    Paymentmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Paymentmodel.fromJson(Map<String, dynamic> json) => Paymentmodel(
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

    int status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
    };
}
