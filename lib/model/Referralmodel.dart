// To parse this JSON data, do
//
//     final referralmodel = referralmodelFromJson(jsonString);

import 'dart:convert';

Referralmodel referralmodelFromJson(String str) => Referralmodel.fromJson(json.decode(str));

String referralmodelToJson(Referralmodel data) => json.encode(data.toJson());

class Referralmodel {
    Referralmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Referralmodel.fromJson(Map<String, dynamic> json) => Referralmodel(
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
        this.referal,
        this.point,
        this.referedList,
    });

    Referal referal;
    double point;
    List<ReferedList> referedList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        referal: json["Referal"] == null ? null : Referal.fromJson(json["Referal"]),
        point: json["point"] == null ? null : json["point"].toDouble(),
        referedList: json["ReferedList"] == null ? null : List<ReferedList>.from(json["ReferedList"].map((x) => ReferedList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Referal": referal == null ? null : referal.toJson(),
        "point": point == null ? null : point,
        "ReferedList": referedList == null ? null : List<dynamic>.from(referedList.map((x) => x.toJson())),
    };
}

class Referal {
    Referal({
        this.id,
        this.userId,
        this.referalId,
        this.referalFrom,
        this.point,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String referalId;
    var referalFrom;
    var point;
    DateTime createdAt;
    DateTime updatedAt;

    factory Referal.fromJson(Map<String, dynamic> json) => Referal(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        referalId: json["referalId"] == null ? null : json["referalId"],
        referalFrom: json["referalFrom"],
        point: json["point"] == null ? null : json["point"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "referalId": referalId == null ? null : referalId,
        "referalFrom": referalFrom,
        "point": point == null ? null : point,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}

class ReferedList {
    ReferedList({
        this.userId,
        this.name,
        this.phone,
        this.paymentDates,
    });

    int userId;
    String name;
    String phone;
    List<PaymentDate> paymentDates;

    factory ReferedList.fromJson(Map<String, dynamic> json) => ReferedList(
        userId: json["UserId"] == null ? null : json["UserId"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        paymentDates: json["payment_dates"] == null ? null : List<PaymentDate>.from(json["payment_dates"].map((x) => PaymentDate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "payment_dates": paymentDates == null ? null : List<dynamic>.from(paymentDates.map((x) => x.toJson())),
    };
}

class PaymentDate {
    PaymentDate({
        this.id,
        this.userId,
        this.schemeId,
        this.schemeAmountId,
        this.subscriptionId,
        this.paymentStartDates,
        this.paymentEndDates,
        this.order,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    int schemeId;
    int schemeAmountId;
    int subscriptionId;
    DateTime paymentStartDates;
    DateTime paymentEndDates;
    int order;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory PaymentDate.fromJson(Map<String, dynamic> json) => PaymentDate(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId: json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        subscriptionId: json["subscriptionId"] == null ? null : json["subscriptionId"],
        paymentStartDates: json["PaymentStartDates"] == null ? null : DateTime.parse(json["PaymentStartDates"]),
        paymentEndDates: json["PaymentEndDates"] == null ? null : DateTime.parse(json["PaymentEndDates"]),
        order: json["order"] == null ? null : json["order"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "PaymentStartDates": paymentStartDates == null ? null : "${paymentStartDates.year.toString().padLeft(4, '0')}-${paymentStartDates.month.toString().padLeft(2, '0')}-${paymentStartDates.day.toString().padLeft(2, '0')}",
        "PaymentEndDates": paymentEndDates == null ? null : "${paymentEndDates.year.toString().padLeft(4, '0')}-${paymentEndDates.month.toString().padLeft(2, '0')}-${paymentEndDates.day.toString().padLeft(2, '0')}",
        "order": order == null ? null : order,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
