// To parse this JSON data, do
//
//     final agentpendingmodel = agentpendingmodelFromJson(jsonString);

import 'dart:convert';

Agentpendingmodel agentpendingmodelFromJson(String str) => Agentpendingmodel.fromJson(json.decode(str));

String agentpendingmodelToJson(Agentpendingmodel data) => json.encode(data.toJson());

class Agentpendingmodel {
    Agentpendingmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Agentpendingmodel.fromJson(Map<String, dynamic> json) => Agentpendingmodel(
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
        this.adminpayment,
        this.pending,
    });

    List<Adminpayment> adminpayment;
    int pending;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminpayment: json["Adminpayment"] == null ? null : List<Adminpayment>.from(json["Adminpayment"].map((x) => Adminpayment.fromJson(x))),
        pending: json["Pending"] == null ? null : json["Pending"],
    );

    Map<String, dynamic> toJson() => {
        "Adminpayment": adminpayment == null ? null : List<dynamic>.from(adminpayment.map((x) => x.toJson())),
        "Pending": pending == null ? null : pending,
    };
}

class Adminpayment {
    Adminpayment({
        this.id,
        this.agentId,
        this.fromdate,
        this.todate,
        this.pendingamount,
        this.notes,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int agentId;
    DateTime fromdate;
    DateTime todate;
    int pendingamount;
    String notes;
    DateTime createdAt;
    DateTime updatedAt;

    factory Adminpayment.fromJson(Map<String, dynamic> json) => Adminpayment(
        id: json["id"] == null ? null : json["id"],
        agentId: json["AgentId"] == null ? null : json["AgentId"],
        fromdate: json["fromdate"] == null ? null : DateTime.parse(json["fromdate"]),
        todate: json["todate"] == null ? null : DateTime.parse(json["todate"]),
        pendingamount: json["pendingamount"] == null ? null : json["pendingamount"],
        notes: json["notes"] == null ? null : json["notes"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "AgentId": agentId == null ? null : agentId,
        "fromdate": fromdate == null ? null : "${fromdate.year.toString().padLeft(4, '0')}-${fromdate.month.toString().padLeft(2, '0')}-${fromdate.day.toString().padLeft(2, '0')}",
        "todate": todate == null ? null : "${todate.year.toString().padLeft(4, '0')}-${todate.month.toString().padLeft(2, '0')}-${todate.day.toString().padLeft(2, '0')}",
        "pendingamount": pendingamount == null ? null : pendingamount,
        "notes": notes == null ? null : notes,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
