// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    NotificationModel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    Data data;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
        this.notification,
    });

    String status;
    List<Notification> notification;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        notification: json["notification"] == null ? null : List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "notification": notification == null ? null : List<dynamic>.from(notification.map((x) => x.toJson())),
    };
}

class Notification {
    Notification({
        this.id,
        this.title,
        this.description,
        this.userId,
        this.subscriptionId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String title;
    String description;
    int userId;
    int subscriptionId;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        userId: json["UserId"] == null ? null : json["UserId"],
        subscriptionId: json["subscriptionId"] == null ? null : json["subscriptionId"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "UserId": userId == null ? null : userId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
