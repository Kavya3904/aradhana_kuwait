// To parse this JSON data, do
//
//     final profileditmodel = profileditmodelFromJson(jsonString);

import 'dart:convert';

Profileditmodel profileditmodelFromJson(String str) => Profileditmodel.fromJson(json.decode(str));

String profileditmodelToJson(Profileditmodel data) => json.encode(data.toJson());

class Profileditmodel {
    Profileditmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Profileditmodel.fromJson(Map<String, dynamic> json) => Profileditmodel(
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
        this.name,
        this.email,
        this.address,
        this.phone,
        this.dob,
        this.aCNumber,
        this.adhaarcard,
        this.pancard,
        this.nominee,
        this.nomineeRelation,
        this.nomineePhone,
        this.pincode,
        this.district,
        this.state,
        this.country,
        this.image,
        this.referalId,
        this.point,
        this.userType,
        this.agentId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String name;
    String email;
    String address;
    String phone;
    var dob;
    dynamic aCNumber;
    dynamic adhaarcard;
    String pancard;
    String nominee;
    String nomineeRelation;
    String nomineePhone;
    String pincode;
    int district;
    int state;
    int country;
    dynamic image;
    String referalId;
    String point;
    int userType;
    dynamic agentId;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        aCNumber: json["a_c_number"],
        adhaarcard: json["adhaarcard"],
        pancard: json["pancard"] == null ? null : json["pancard"],
        nominee: json["nominee"] == null ? null : json["nominee"],
        nomineeRelation: json["nominee_relation"] == null ? null : json["nominee_relation"],
        nomineePhone: json["nominee_phone"] == null ? null : json["nominee_phone"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        district: json["district"] == null ? null : json["district"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        image: json["image"],
        referalId: json["referalId"] == null ? null : json["referalId"],
        point: json["point"] == null ? null : json["point"],
        userType: json["userType"] == null ? null : json["userType"],
        agentId: json["agentId"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "dob": dob == null ? null : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "a_c_number": aCNumber,
        "adhaarcard": adhaarcard,
        "pancard": pancard == null ? null : pancard,
        "nominee": nominee == null ? null : nominee,
        "nominee_relation": nomineeRelation == null ? null : nomineeRelation,
        "nominee_phone": nomineePhone == null ? null : nomineePhone,
        "pincode": pincode == null ? null : pincode,
        "district": district == null ? null : district,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "image": image,
        "referalId": referalId == null ? null : referalId,
        "point": point == null ? null : point,
        "userType": userType == null ? null : userType,
        "agentId": agentId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
