// To parse this JSON data, do
//
//     final dashboardmodel = dashboardmodelFromJson(jsonString);

import 'dart:convert';

Dashboardmodel dashboardmodelFromJson(String str) => Dashboardmodel.fromJson(json.decode(str));

String dashboardmodelToJson(Dashboardmodel data) => json.encode(data.toJson());

class Dashboardmodel {
    Dashboardmodel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory Dashboardmodel.fromJson(Map<String, dynamic> json) => Dashboardmodel(
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
        this.bannerImage,
        this.schemeImage,
        this.bannerContent,
        this.schemeDetails,
        this.todayRate,
        this.gramPrevious,
    });

    List<Image> bannerImage;
    List<Image> schemeImage;
    BannerContent bannerContent;
    SchemeDetails schemeDetails;
    String todayRate;
    String gramPrevious;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bannerImage: json["banner_image"] == null ? null : List<Image>.from(json["banner_image"].map((x) => Image.fromJson(x))),
        schemeImage: json["scheme_image"] == null ? null : List<Image>.from(json["scheme_image"].map((x) => Image.fromJson(x))),
        bannerContent: json["banner_content"] == null ? null : BannerContent.fromJson(json["banner_content"]),
        schemeDetails: json["scheme_details"] == null ? null : SchemeDetails.fromJson(json["scheme_details"]),
        todayRate: json["todayRate"] == null ? null : json["todayRate"],
        gramPrevious: json["gram_previous"] == null ? null : json["gram_previous"],
    );

    Map<String, dynamic> toJson() => {
        "banner_image": bannerImage == null ? null : List<dynamic>.from(bannerImage.map((x) => x.toJson())),
        "scheme_image": schemeImage == null ? null : List<dynamic>.from(schemeImage.map((x) => x.toJson())),
        "banner_content": bannerContent == null ? null : bannerContent.toJson(),
        "scheme_details": schemeDetails == null ? null : schemeDetails.toJson(),
        "todayRate": todayRate == null ? null : todayRate,
        "gram_previous": gramPrevious == null ? null : gramPrevious,
    };
}

class BannerContent {
    BannerContent({
        this.id,
        this.bannerContent,
        this.schemeContent,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String bannerContent;
    dynamic schemeContent;
    String status;
    dynamic createdAt;
    dynamic updatedAt;

    factory BannerContent.fromJson(Map<String, dynamic> json) => BannerContent(
        id: json["id"] == null ? null : json["id"],
        bannerContent: json["banner_content"] == null ? null : json["banner_content"],
        schemeContent: json["scheme_content"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "banner_content": bannerContent == null ? null : bannerContent,
        "scheme_content": schemeContent,
        "status": status == null ? null : status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Image {
    Image({
        this.id,
        this.bannerImage,
        this.imageType,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String bannerImage;
    int imageType;
    String status;
    dynamic createdAt;
    dynamic updatedAt;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        bannerImage: json["banner_image"] == null ? null : json["banner_image"],
        imageType: json["image_type"] == null ? null : json["image_type"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "banner_image": bannerImage == null ? null : bannerImage,
        "image_type": imageType == null ? null : imageType,
        "status": status == null ? null : status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class SchemeDetails {
    SchemeDetails({
        this.id,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String description;
    dynamic createdAt;
    dynamic updatedAt;

    factory SchemeDetails.fromJson(Map<String, dynamic> json) => SchemeDetails(
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
