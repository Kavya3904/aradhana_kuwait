// To parse this JSON data, do
//
//     final countrymodel = countrymodelFromJson(jsonString);

import 'dart:convert';

Countrymodel countrymodelFromJson(String str) => Countrymodel.fromJson(json.decode(str));

String countrymodelToJson(Countrymodel data) => json.encode(data.toJson());

class Countrymodel {
    Countrymodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Countrymodel.fromJson(Map<String, dynamic> json) => Countrymodel(
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
        this.countryList,
    });

    int status;
    List<CountryList> countryList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        countryList: json["country_list"] == null ? null : List<CountryList>.from(json["country_list"].map((x) => CountryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "country_list": countryList == null ? null : List<dynamic>.from(countryList.map((x) => x.toJson())),
    };
}

class CountryList {
    CountryList({
        this.id,
        this.sortname,
        this.countryName,
        this.phonecode,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String sortname;
    String countryName;
    String phonecode;
    DateTime createdAt;
    DateTime updatedAt;

    factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        id: json["id"] == null ? null : json["id"],
        sortname: json["sortname"] == null ? null : json["sortname"],
        countryName: json["countryName"] == null ? null : json["countryName"],
        phonecode: json["phonecode"] == null ? null : json["phonecode"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sortname": sortname == null ? null : sortname,
        "countryName": countryName == null ? null : countryName,
        "phonecode": phonecode == null ? null : phonecode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
