// To parse this JSON data, do
//
//     final schemeAmountListmodel = schemeAmountListmodelFromJson(jsonString);

import 'dart:convert';

SchemeAmountListmodel schemeAmountListmodelFromJson(String str) =>
    SchemeAmountListmodel.fromJson(json.decode(str));

String schemeAmountListmodelToJson(SchemeAmountListmodel data) =>
    json.encode(data.toJson());

class SchemeAmountListmodel {
  SchemeAmountListmodel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory SchemeAmountListmodel.fromJson(Map<String, dynamic> json) =>
      SchemeAmountListmodel(
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
    this.fixed,
    this.varient,
    this.termsandcondtion,
  });

  int status;
  List<Fixed> fixed;
  List<Fixed> varient;
  List<Termsandcondtion> termsandcondtion;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        fixed: json["Fixed"] == null
            ? null
            : List<Fixed>.from(json["Fixed"].map((x) => Fixed.fromJson(x))),
        varient: json["Varient"] == null
            ? null
            : List<Fixed>.from(json["Varient"].map((x) => Fixed.fromJson(x))),
        termsandcondtion: json["termsandcondtion"] == null
            ? null
            : List<Termsandcondtion>.from(json["termsandcondtion"]
                .map((x) => Termsandcondtion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "Fixed": fixed == null
            ? null
            : List<dynamic>.from(fixed.map((x) => x.toJson())),
        "Varient": varient == null
            ? null
            : List<dynamic>.from(varient.map((x) => x.toJson())),
        "termsandcondtion": termsandcondtion == null
            ? null
            : List<dynamic>.from(termsandcondtion.map((x) => x.toJson())),
      };
}

class Fixed {
  Fixed({
    this.id,
    this.schemeId,
    this.paymentType,
    this.amount,
    this.amountTo,
    this.termsId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int schemeId;
  int paymentType;
  String amount;
  String amountTo;
  DateTime createdAt;
  int termsId;
  DateTime updatedAt;

  factory Fixed.fromJson(Map<String, dynamic> json) => Fixed(
        id: json["id"] == null ? null : json["id"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        amount: json["amount"] == null ? null : json["amount"],
        amountTo: json["amount_to"] == null ? null : json["amount_to"],
        termsId: json["termsId"] == null ? null : json["termsId"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "SchemeId": schemeId == null ? null : schemeId,
        "payment_type": paymentType == null ? null : paymentType,
        "amount": amount == null ? null : amount,
        "amount_to": amountTo == null ? null : amountTo,
        "termsId": termsId == null ? null : termsId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Termsandcondtion {
  Termsandcondtion({
    this.id,
    this.branchId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int branchId;
  String title;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  factory Termsandcondtion.fromJson(Map<String, dynamic> json) =>
      Termsandcondtion(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
