// To parse this JSON data, do
//
//     final prePaymentModel = prePaymentModelFromJson(jsonString);

import 'dart:convert';

PrePaymentModel prePaymentModelFromJson(String str) =>
    PrePaymentModel.fromJson(json.decode(str));

String prePaymentModelToJson(PrePaymentModel data) =>
    json.encode(data.toJson());

class PrePaymentModel {
  bool success;
  String message;
  Data data;

  PrePaymentModel({
    this.success,
    this.message,
    this.data,
  });

  factory PrePaymentModel.fromJson(Map<String, dynamic> json) =>
      PrePaymentModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  bool status;
  OrderId orderId;

  Data({
    this.status,
    this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        orderId: OrderId.fromJson(json["OrderId"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "OrderId": orderId.toJson(),
      };
}

class OrderId {
  String orderId;
  DateTime paymentDate;
  String branchId;
  String sheduledDateId;
  String gram;
  String amount;
  String userId;
  String subscriptionId;
  int status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  OrderId({
    this.orderId,
    this.paymentDate,
    this.branchId,
    this.sheduledDateId,
    this.gram,
    this.amount,
    this.userId,
    this.subscriptionId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
        orderId: json["OrderId"],
        paymentDate: DateTime.parse(json["paymentDate"]),
        branchId: json["branchId"],
        sheduledDateId: json["SheduledDateId"],
        gram: json["gram"],
        amount: json["amount"],
        userId: json["UserId"],
        subscriptionId: json["subscriptionId"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "paymentDate": paymentDate.toIso8601String(),
        "branchId": branchId,
        "SheduledDateId": sheduledDateId,
        "gram": gram,
        "amount": amount,
        "UserId": userId,
        "subscriptionId": subscriptionId,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
