// To parse this JSON data, do
//
//     final bankdetailsmodel = bankdetailsmodelFromJson(jsonString);

import 'dart:convert';

Bankdetailsmodel bankdetailsmodelFromJson(String str) => Bankdetailsmodel.fromJson(json.decode(str));

String bankdetailsmodelToJson(Bankdetailsmodel data) => json.encode(data.toJson());

class Bankdetailsmodel {
    Bankdetailsmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Bankdetailsmodel.fromJson(Map<String, dynamic> json) => Bankdetailsmodel(
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
        this.bankDetails,
        this.upiDetails,
    });

    bool status;
    List<Detail> bankDetails;
    List<Detail> upiDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        bankDetails: json["bank_details"] == null ? null : List<Detail>.from(json["bank_details"].map((x) => Detail.fromJson(x))),
        upiDetails: json["upi_details"] == null ? null : List<Detail>.from(json["upi_details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "bank_details": bankDetails == null ? null : List<dynamic>.from(bankDetails.map((x) => x.toJson())),
        "upi_details": upiDetails == null ? null : List<dynamic>.from(upiDetails.map((x) => x.toJson())),
    };
}

class Detail {
    Detail({
        this.id,
        this.branchId,
        this.bankName,
        this.beneficiaryName,
        this.ifscCode,
        this.accNo,
        this.upiId,
        this.mobNo,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int branchId;
    String bankName;
    String beneficiaryName;
    String ifscCode;
    String accNo;
    String upiId;
    String mobNo;
    int type;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        beneficiaryName: json["beneficiaryName"] == null ? null : json["beneficiaryName"],
        ifscCode: json["ifsc_Code"] == null ? null : json["ifsc_Code"],
        accNo: json["acc_no"] == null ? null : json["acc_no"],
        upiId: json["Upi_id"] == null ? null : json["Upi_id"],
        mobNo: json["mob_no"] == null ? null : json["mob_no"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "bank_name": bankName == null ? null : bankName,
        "beneficiaryName": beneficiaryName == null ? null : beneficiaryName,
        "ifsc_Code": ifscCode == null ? null : ifscCode,
        "acc_no": accNo == null ? null : accNo,
        "Upi_id": upiId == null ? null : upiId,
        "mob_no": mobNo == null ? null : mobNo,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
