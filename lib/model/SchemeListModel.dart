// To parse this JSON data, do
//
//     final schemeListmodel = schemeListmodelFromJson(jsonString);

import 'dart:convert';

SchemeListmodel schemeListmodelFromJson(String str) => SchemeListmodel.fromJson(json.decode(str));

String schemeListmodelToJson(SchemeListmodel data) => json.encode(data.toJson());

class SchemeListmodel {
    SchemeListmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory SchemeListmodel.fromJson(Map<String, dynamic> json) => SchemeListmodel(
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
        this.schemeList,
    });

    int status;
    List<SchemeList> schemeList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        schemeList: json["SchemeList"] == null ? null : List<SchemeList>.from(json["SchemeList"].map((x) => SchemeList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "SchemeList": schemeList == null ? null : List<dynamic>.from(schemeList.map((x) => x.toJson())),
    };
}

class SchemeList {
    SchemeList({
        this.id,
        this.schemeName,
        this.paymentIntervel,
        this.totalInstallment,
        this.status,
        this.schemeType,
        this.checkPaymentInterval,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String schemeName;
    int paymentIntervel;
    int totalInstallment;
    int status;
    dynamic schemeType;
    dynamic checkPaymentInterval;
    DateTime createdAt;
    DateTime updatedAt;

    factory SchemeList.fromJson(Map<String, dynamic> json) => SchemeList(
        id: json["id"] == null ? null : json["id"],
        schemeName: json["schemeName"] == null ? null : json["schemeName"],
        paymentIntervel: json["paymentIntervel"] == null ? null : json["paymentIntervel"],
        totalInstallment: json["totalInstallment"] == null ? null : json["totalInstallment"],
        status: json["status"] == null ? null : json["status"],
        schemeType: json["scheme_type"],
        checkPaymentInterval: json["check_payment_interval"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "schemeName": schemeName == null ? null : schemeName,
        "paymentIntervel": paymentIntervel == null ? null : paymentIntervel,
        "totalInstallment": totalInstallment == null ? null : totalInstallment,
        "status": status == null ? null : status,
        "scheme_type": schemeType,
        "check_payment_interval": checkPaymentInterval,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
