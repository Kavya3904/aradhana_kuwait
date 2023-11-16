import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) =>
    OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) =>
    json.encode(data.toJson());

class OrderStatusModel {
  bool success;
  String message;
  Data data;

  OrderStatusModel({
    this.success,
    this.message,
    this.data,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderStatusModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  bool status;

  Data({
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
