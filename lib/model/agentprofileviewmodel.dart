// To parse this JSON data, do
//
//     final agentprofileviewmodel = agentprofileviewmodelFromJson(jsonString);

import 'dart:convert';

Agentprofileviewmodel agentprofileviewmodelFromJson(String str) => Agentprofileviewmodel.fromJson(json.decode(str));

String agentprofileviewmodelToJson(Agentprofileviewmodel data) => json.encode(data.toJson());

class Agentprofileviewmodel {
    Agentprofileviewmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Agentprofileviewmodel.fromJson(Map<String, dynamic> json) => Agentprofileviewmodel(
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
    });

    String status;
    UserId userId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "userId": userId == null ? null : userId.toJson(),
    };
}

class UserId {
    UserId({
        this.id,
        this.userId,
        this.agentName,
        this.phone,
        this.email,
        this.adhaar,
        this.panNumber,
        this.address,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String agentName;
    String phone;
    String email;
    String adhaar;
    String panNumber;
    String address;
    dynamic image;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        agentName: json["agentName"] == null ? null : json["agentName"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        adhaar: json["adhaar"] == null ? null : json["adhaar"],
        panNumber: json["panNumber"] == null ? null : json["panNumber"],
        address: json["address"] == null ? null : json["address"],
        image: json["image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "agentName": agentName == null ? null : agentName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "adhaar": adhaar == null ? null : adhaar,
        "panNumber": panNumber == null ? null : panNumber,
        "address": address == null ? null : address,
        "image": image,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
