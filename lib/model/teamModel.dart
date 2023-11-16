// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
    TeamModel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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
    });

    bool status;
    List<BankDetail> bankDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        bankDetails: json["bank_details"] == null ? null : List<BankDetail>.from(json["bank_details"].map((x) => BankDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "bank_details": bankDetails == null ? null : List<dynamic>.from(bankDetails.map((x) => x.toJson())),
    };
}

class BankDetail {
    BankDetail({
        this.id,
        this.branchId,
        this.name,
        this.phone,
        this.email,
        this.designation,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int branchId;
    String name;
    String phone;
    String email;
    String designation;
    String description;
    String image;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        name: json["Name"] == null ? null : json["Name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        designation: json["designation"] == null ? null : json["designation"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "Name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "designation": designation == null ? null : designation,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
