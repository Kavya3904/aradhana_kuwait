// To parse this JSON data, do
//
//     final statemodel = statemodelFromJson(jsonString);

import 'dart:convert';

Statemodel statemodelFromJson(String str) => Statemodel.fromJson(json.decode(str));

String statemodelToJson(Statemodel data) => json.encode(data.toJson());

class Statemodel {
    Statemodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Statemodel.fromJson(Map<String, dynamic> json) => Statemodel(
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
        this.stateList,
    });

    int status;
    List<StateList> stateList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        stateList: json["state_list"] == null ? null : List<StateList>.from(json["state_list"].map((x) => StateList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "state_list": stateList == null ? null : List<dynamic>.from(stateList.map((x) => x.toJson())),
    };
}

class StateList {
    StateList({
        this.id,
        this.countryId,
        this.stateName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int countryId;
    String stateName;
    DateTime createdAt;
    DateTime updatedAt;

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json["id"] == null ? null : json["id"],
        countryId: json["countryId"] == null ? null : json["countryId"],
        stateName: json["stateName"] == null ? null : json["stateName"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "countryId": countryId == null ? null : countryId,
        "stateName": stateName == null ? null : stateName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
