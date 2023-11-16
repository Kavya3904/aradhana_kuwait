// To parse this JSON data, do
//
//     final paymentdetailsmodel = paymentdetailsmodelFromJson(jsonString);

import 'dart:convert';

Paymentdetailsmodel paymentdetailsmodelFromJson(String str) =>
    Paymentdetailsmodel.fromJson(json.decode(str));

String paymentdetailsmodelToJson(Paymentdetailsmodel data) =>
    json.encode(data.toJson());

class Paymentdetailsmodel {
  Paymentdetailsmodel({this.success, this.message, this.data});

  bool success;
  String message;
  Data data;

  factory Paymentdetailsmodel.fromJson(Map<String, dynamic> json) =>
      Paymentdetailsmodel(
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
  Data(
      {this.paymentsList,
      this.sumAmount,
      this.sumGram,
      this.totalInstallment,
      this.schemeName,
      this.totalPoint,
      this.subsciption});

  List<PaymentsList> paymentsList;
  var sumAmount;
  var sumGram;
  var totalInstallment;
  String schemeName;
  List<String> totalPoint;
  Subsciption subsciption;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentsList: json["paymentsList"] == null
            ? null
            : List<PaymentsList>.from(
                json["paymentsList"].map((x) => PaymentsList.fromJson(x))),
        sumAmount: json["sum_amount"] == null ? null : json["sum_amount"],
        sumGram: json["sum_gram"] == null ? null : json["sum_gram"],
        totalInstallment:
            json["totalInstallment"] == null ? null : json["totalInstallment"],
        schemeName: json["SchemeName"] == null ? null : json["SchemeName"],
        totalPoint: json["TotalPoint"] == null
            ? null
            : List<String>.from(json["TotalPoint"].map((x) => x)),
        subsciption: json["subsciption"] == null
            ? null
            : Subsciption.fromJson(json["subsciption"]),
      );

  Map<String, dynamic> toJson() => {
        "paymentsList": paymentsList == null
            ? null
            : List<dynamic>.from(paymentsList.map((x) => x.toJson())),
        "sum_amount": sumAmount == null ? null : sumAmount,
        "sum_gram": sumGram == null ? null : sumGram,
        "totalInstallment": totalInstallment == null ? null : totalInstallment,
        "SchemeName": schemeName == null ? null : schemeName,
        "TotalPoint": totalPoint == null
            ? null
            : List<dynamic>.from(totalPoint.map((x) => x)),
        "subsciption": subsciption == null ? null : subsciption.toJson(),
      };
}

class PaymentsList {
  PaymentsList({
    this.id,
    this.voucherNumber,
    this.userId,
    this.sheduledDateId,
    this.subscriptionId,
    this.gram,
    this.amount,
    this.taransactionId,
    this.paymentDate,
    this.paidBy,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String voucherNumber;
  int userId;
  int sheduledDateId;
  int subscriptionId;
  String gram;
  String amount;
  String taransactionId;
  DateTime paymentDate;
  int paidBy;
  var paymentMethod;
  var status;
  DateTime createdAt;
  DateTime updatedAt;

  factory PaymentsList.fromJson(Map<String, dynamic> json) => PaymentsList(
        id: json["id"] == null ? null : json["id"],
        voucherNumber:
            json["voucherNumber"] == null ? null : json["voucherNumber"],
        userId: json["UserId"] == null ? null : json["UserId"],
        sheduledDateId:
            json["SheduledDateId"] == null ? null : json["SheduledDateId"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        gram: json["gram"] == null ? null : json["gram"],
        amount: json["amount"] == null ? null : json["amount"],
        taransactionId:
            json["taransactionId"] == null ? null : json["taransactionId"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
        paidBy: json["paidBy"] == null ? null : json["paidBy"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
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
        "voucherNumber": voucherNumber == null ? null : voucherNumber,
        "UserId": userId == null ? null : userId,
        "SheduledDateId": sheduledDateId == null ? null : sheduledDateId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "gram": gram == null ? null : gram,
        "amount": amount == null ? null : amount,
        "taransactionId": taransactionId == null ? null : taransactionId,
        "paymentDate": paymentDate == null
            ? null
            : "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "paidBy": paidBy == null ? null : paidBy,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Subsciption {
  Subsciption({
    this.id,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.startDate,
    this.endDate,
    this.subscriptionType,
    this.schemeType,
    this.dateCheck,
    this.redeemType,
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
  var subscriptionType;
  dynamic schemeType;
  dynamic dateCheck;
  var redeemType;
  var status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subsciption.fromJson(Map<String, dynamic> json) => Subsciption(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId:
            json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        startDate: json["StartDate"] == null
            ? null
            : DateTime.parse(json["StartDate"]),
        endDate: json["EndDate"],
        subscriptionType: json["subscription_type"] == null
            ? null
            : json["subscription_type"],
        schemeType: json["scheme_type"],
        dateCheck: json["date_check"],
        redeemType: json["redeem_type"] == null ? null : json["redeem_type"],
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
        "subscription_type": subscriptionType == null ? null : subscriptionType,
        "scheme_type": schemeType,
        "date_check": dateCheck,
        "redeem_type": redeemType == null ? null : redeemType,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
