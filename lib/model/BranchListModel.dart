// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

BranchListModel branchListModelFromJson(String str) => BranchListModel.fromJson(json.decode(str));

String branchListModelToJson(BranchListModel data) => json.encode(data.toJson());

class BranchListModel {
    BranchListModel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory BranchListModel.fromJson(Map<String, dynamic> json) => BranchListModel(
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
        this.branches,
    });

    List<Branch> branches;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        branches: json["branches"] == null ? null : List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "branches": branches == null ? null : List<dynamic>.from(branches.map((x) => x.toJson())),
    };
}

class Branch {
    Branch({
        this.id,
        this.name,
        this.email,
    });

    int id;
    String name;
    String email;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
    };
}
