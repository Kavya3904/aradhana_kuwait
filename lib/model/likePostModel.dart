// To parse this JSON data, do
//
//     final likePostModel = likePostModelFromJson(jsonString);

import 'dart:convert';

LikePostModel likePostModelFromJson(String str) =>
    LikePostModel.fromJson(json.decode(str));

String likePostModelToJson(LikePostModel data) => json.encode(data.toJson());

class LikePostModel {
  LikePostModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory LikePostModel.fromJson(Map<String, dynamic> json) => LikePostModel(
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
  });

  bool status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
      };
}
