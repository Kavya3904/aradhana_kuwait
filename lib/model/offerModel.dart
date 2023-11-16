import 'dart:convert';

Offermodel offermodelFromJson(String str) =>
    Offermodel.fromJson(json.decode(str));

String offermodelToJson(Offermodel data) => json.encode(data.toJson());

class Offermodel {
  Offermodel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory Offermodel.fromJson(Map<String, dynamic> json) => Offermodel(
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
    this.offers,
  });

  bool status;
  List<Offer> offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        offers: json["offers"] == null
            ? null
            : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "offers": offers == null
            ? null
            : List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    this.id,
    this.productName,
    this.description,
    this.title,
    this.offerCode,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.likeCount,
    this.isLiked,
  });

  int id;
  String productName;
  String description;
  String title;
  String offerCode;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int likeCount;
  bool isLiked;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"] == null ? null : json["id"],
        productName: json["product_name"] == null ? null : json["product_name"],
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        offerCode: json["offer_code"] == null ? null : json["offer_code"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isLiked: json["like_status"] == null ? null : json["like_status"],
        likeCount: json["total_count"] == null ? null : json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_name": productName == null ? null : productName,
        "description": description == null ? null : description,
        "title": title == null ? null : title,
        "offer_code": offerCode == null ? null : offerCode,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "like_status": isLiked == null ? null : isLiked,
        "total_count": likeCount == null ? null : likeCount,
      };
}
