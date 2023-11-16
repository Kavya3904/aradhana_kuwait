// To parse this JSON data, do
//
//     final aboutusmodel = aboutusmodelFromJson(jsonString);

import 'dart:convert';

Aboutusmodel aboutusmodelFromJson(String str) => Aboutusmodel.fromJson(json.decode(str));

String aboutusmodelToJson(Aboutusmodel data) => json.encode(data.toJson());

class Aboutusmodel {
    Aboutusmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Aboutusmodel.fromJson(Map<String, dynamic> json) => Aboutusmodel(
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
        this.aboutUs,
    });

    AboutUs aboutUs;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        aboutUs: json["AboutUs"] == null ? null : AboutUs.fromJson(json["AboutUs"]),
    );

    Map<String, dynamic> toJson() => {
        "AboutUs": aboutUs == null ? null : aboutUs.toJson(),
    };
}

class AboutUs {
    AboutUs({
        this.id,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String description;
    dynamic createdAt;
    dynamic updatedAt;

    factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "description": description == null ? null : description,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
