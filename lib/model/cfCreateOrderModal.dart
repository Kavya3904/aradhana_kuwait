// To parse this JSON data, do
//
//     final createOrder = createOrderFromJson(jsonString);

import 'dart:convert';

CreateOrder createOrderFromJson(String str) =>
    CreateOrder.fromJson(json.decode(str));

String createOrderToJson(CreateOrder data) => json.encode(data.toJson());

class CreateOrder {
  int cfOrderId;
  DateTime createdAt;
  CustomerDetails customerDetails;
  String entity;
  int orderAmount;
  String orderCurrency;
  DateTime orderExpiryTime;
  String orderId;
  OrderMeta orderMeta;
  dynamic orderNote;
  List<dynamic> orderSplits;
  String orderStatus;
  dynamic orderTags;
  String paymentSessionId;
  Payments payments;
  Payments refunds;
  Payments settlements;
  dynamic terminalData;

  CreateOrder({
    this.cfOrderId,
    this.createdAt,
    this.customerDetails,
    this.entity,
    this.orderAmount,
    this.orderCurrency,
    this.orderExpiryTime,
    this.orderId,
    this.orderMeta,
    this.orderNote,
    this.orderSplits,
    this.orderStatus,
    this.orderTags,
    this.paymentSessionId,
    this.payments,
    this.refunds,
    this.settlements,
    this.terminalData,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
        cfOrderId: json["cf_order_id"],
        createdAt: DateTime.parse(json["created_at"]),
        customerDetails: CustomerDetails.fromJson(json["customer_details"]),
        entity: json["entity"],
        orderAmount: json["order_amount"],
        orderCurrency: json["order_currency"],
        orderExpiryTime: DateTime.parse(json["order_expiry_time"]),
        orderId: json["order_id"],
        orderMeta: OrderMeta.fromJson(json["order_meta"]),
        orderNote: json["order_note"],
        orderSplits: List<dynamic>.from(json["order_splits"].map((x) => x)),
        orderStatus: json["order_status"],
        orderTags: json["order_tags"],
        paymentSessionId: json["payment_session_id"],
        payments: Payments.fromJson(json["payments"]),
        refunds: Payments.fromJson(json["refunds"]),
        settlements: Payments.fromJson(json["settlements"]),
        terminalData: json["terminal_data"],
      );

  Map<String, dynamic> toJson() => {
        "cf_order_id": cfOrderId,
        "created_at": createdAt.toIso8601String(),
        "customer_details": customerDetails.toJson(),
        "entity": entity,
        "order_amount": orderAmount,
        "order_currency": orderCurrency,
        "order_expiry_time": orderExpiryTime.toIso8601String(),
        "order_id": orderId,
        "order_meta": orderMeta.toJson(),
        "order_note": orderNote,
        "order_splits": List<dynamic>.from(orderSplits.map((x) => x)),
        "order_status": orderStatus,
        "order_tags": orderTags,
        "payment_session_id": paymentSessionId,
        "payments": payments.toJson(),
        "refunds": refunds.toJson(),
        "settlements": settlements.toJson(),
        "terminal_data": terminalData,
      };
}

class CustomerDetails {
  String customerId;
  String customerName;
  String customerEmail;
  String customerPhone;

  CustomerDetails({
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
      };
}

class OrderMeta {
  dynamic returnUrl;
  dynamic notifyUrl;
  dynamic paymentMethods;

  OrderMeta({
    this.returnUrl,
    this.notifyUrl,
    this.paymentMethods,
  });

  factory OrderMeta.fromJson(Map<String, dynamic> json) => OrderMeta(
        returnUrl: json["return_url"],
        notifyUrl: json["notify_url"],
        paymentMethods: json["payment_methods"],
      );

  Map<String, dynamic> toJson() => {
        "return_url": returnUrl,
        "notify_url": notifyUrl,
        "payment_methods": paymentMethods,
      };
}

class Payments {
  String url;

  Payments({
    this.url,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
