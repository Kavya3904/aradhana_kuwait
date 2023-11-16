// To parse this JSON data, do
//
//     final districtmodel = districtmodelFromJson(jsonString);

import 'dart:convert';

Districtmodel districtmodelFromJson(String str) => Districtmodel.fromJson(json.decode(str));

String districtmodelToJson(Districtmodel data) => json.encode(data.toJson());

class Districtmodel {
    Districtmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Districtmodel.fromJson(Map<String, dynamic> json) => Districtmodel(
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
        this.districtsList,
    });

    int status;
    List<DistrictsList> districtsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        districtsList: json["districts_list"] == null ? null : List<DistrictsList>.from(json["districts_list"].map((x) => DistrictsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "districts_list": districtsList == null ? null : List<dynamic>.from(districtsList.map((x) => x.toJson())),
    };
}

class DistrictsList {
    DistrictsList({
        this.id,
        this.stateId,
        this.districtName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int stateId;
    String districtName;
    DateTime createdAt;
    DateTime updatedAt;

    factory DistrictsList.fromJson(Map<String, dynamic> json) => DistrictsList(
        id: json["id"] == null ? null : json["id"],
        stateId: json["stateId"] == null ? null : json["stateId"],
        districtName: json["districtName"] == null ? null : json["districtName"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "stateId": stateId == null ? null : stateId,
        "districtName": districtName == null ? null : districtName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
