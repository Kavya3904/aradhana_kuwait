// To parse this JSON data, do
//
//     final sheduledmodel = sheduledmodelFromJson(jsonString);

import 'dart:convert';

Sheduledmodel sheduledmodelFromJson(String str) =>
    Sheduledmodel.fromJson(json.decode(str));
String sheduledmodelToJson(Sheduledmodel data) => json.encode(data.toJson());

class Sheduledmodel {
  Sheduledmodel({
    this.success,
    this.message,
    this.data,
  });
  bool success;
  String message;
  Data data;
  factory Sheduledmodel.fromJson(Map<String, dynamic> json) => Sheduledmodel(
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
    this.half,
    this.halfPaymentSum,
    this.sheduledList,
    this.upcomingPayment,
    this.unPaidPayment,
    this.paidPayment,
    this.monthlyAmont,
    this.amountTo,
    this.paymentType,
    this.todayRate,
    this.todayEarnings,
    this.average,
    this.sumAmount,
    this.sumGram,
    this.schemeName,
    this.lastPaymentStatus,
    this.notificationCount,
    this.termsandcondtion,
    this.versions,
    this.schemetype,
    this.referalId,
    this.subs,
    this.lastDate,
    this.lastPaymentAndDate,
  });

  String half;
  String status;
  List<SheduledList> sheduledList;
  List<SheduledList> upcomingPayment;
  List<LastDate> unPaidPayment;
  List<LastDate> paidPayment;
  var monthlyAmont;
  dynamic halfPaymentSum;
  dynamic amountTo;
  var paymentType;
  var todayRate;
  double todayEarnings;
  var sumAmount;
  var sumGram;
  var schemetype;
  var schemeName;
  var notificationCount;
  Termsandcondtion termsandcondtion;
  Versions versions;
  List<String> referalId;
  Subs subs;
  var average;
  List<LastDate> lastDate;
  LastPaymentAndDate lastPaymentAndDate;
  LastPaymentStatus lastPaymentStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        half: json["half"] == null ? null : json["half"],
        halfPaymentSum:
            json["half_payment_sum"] == null ? null : json["half_payment_sum"],
        average: json["average"] == null ? null : json["average"],
        sheduledList: json["SheduledList"] == null
            ? null
            : List<SheduledList>.from(
                json["SheduledList"].map((x) => SheduledList.fromJson(x))),
        upcomingPayment: json["UpcomingPayment"] == null
            ? null
            : List<SheduledList>.from(
                json["UpcomingPayment"].map((x) => SheduledList.fromJson(x))),
        unPaidPayment: json["unPaidPayment"] == null
            ? null
            : List<LastDate>.from(
                json["unPaidPayment"].map((x) => LastDate.fromJson(x))),
        paidPayment: json["paidPayment"] == null
            ? null
            : List<LastDate>.from(
                json["paidPayment"].map((x) => LastDate.fromJson(x))),
        monthlyAmont:
            json["MonthlyAmont"] == null ? null : json["MonthlyAmont"],
        amountTo: json["Amount_to"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        todayRate: json["TodayRate"] == null ? null : json["TodayRate"],
        todayEarnings: json["todayEarnings"] == null
            ? null
            : json["todayEarnings"].toDouble(),
        sumAmount: json["sum_amount"] == null ? null : json["sum_amount"],
        sumGram: json["sum_gram"] == null ? null : json["sum_gram"],
        schemetype: json["scheme_type"] == null ? null : json["scheme_type"],
        schemeName: json["schemeName"] == null ? null : json["schemeName"],
        notificationCount:
            json["NotificationCount"] == null ? "0" : json["NotificationCount"],
        termsandcondtion: json["termsandcondtion"] == null
            ? null
            : Termsandcondtion.fromJson(json["termsandcondtion"]),
        versions: json["versions"] == null
            ? null
            : Versions.fromJson(json["versions"]),
        referalId: json["referalId"] == null
            ? null
            : List<String>.from(json["referalId"].map((x) => x)),
        subs: json["subs"] == null ? null : Subs.fromJson(json["subs"]),
        lastDate: json["Last_date"] == null
            ? null
            : List<LastDate>.from(
                json["Last_date"].map((x) => LastDate.fromJson(x))),
        lastPaymentAndDate: json["last_payment_and_date"] == null
            ? null
            : LastPaymentAndDate.fromJson(json["last_payment_and_date"]),
        lastPaymentStatus: json["last_payment_status"] == null
            ? null
            : LastPaymentStatus.fromJson(json["last_payment_status"]),
      );
  Map<String, dynamic> toJson() => {
        "half": half == null ? null : half,
        "status": status == null ? null : status,
        "half_payment_sum": halfPaymentSum == null ? null : halfPaymentSum,
        "SheduledList": sheduledList == null
            ? null
            : List<dynamic>.from(sheduledList.map((x) => x.toJson())),
        "UpcomingPayment": upcomingPayment == null
            ? null
            : List<dynamic>.from(upcomingPayment.map((x) => x.toJson())),
        "average": average == null ? null : average,
        "unPaidPayment": unPaidPayment == null
            ? null
            : List<dynamic>.from(unPaidPayment.map((x) => x.toJson())),
        "paidPayment": paidPayment == null
            ? null
            : List<dynamic>.from(paidPayment.map((x) => x.toJson())),
        "MonthlyAmont": monthlyAmont == null ? null : monthlyAmont,
        "Amount_to": amountTo,
        "payment_type": paymentType == null ? null : paymentType,
        "TodayRate": todayRate == null ? null : todayRate,
        "todayEarnings": todayEarnings == null ? null : todayEarnings,
        "sum_amount": sumAmount == null ? null : sumAmount,
        "sum_gram": sumGram == null ? null : sumGram,
        "schemeName": schemeName == null ? null : schemeName,
        "scheme_type": schemetype == null ? null : schemetype,
        "NotificationCount":
            notificationCount == null ? null : notificationCount,
        "termsandcondtion":
            termsandcondtion == null ? "" : termsandcondtion.toJson(),
        "versions": versions == null ? null : versions.toJson(),
        "referalId": referalId == null
            ? null
            : List<dynamic>.from(referalId.map((x) => x)),
        "subs": subs == null ? null : subs.toJson(),
        "Last_date": lastDate == null
            ? null
            : List<dynamic>.from(
                lastDate.map((x) => x.toJson()),
              ),
        "last_payment_and_date":
            lastPaymentAndDate == null ? null : lastPaymentAndDate.toJson(),
        "last_payment_status":
            lastPaymentStatus == null ? null : lastPaymentStatus.toJson(),
      };
}

class LastPaymentStatus {
  LastPaymentStatus({
    this.id,
    this.userId,
    this.subscriptionId,
    this.lastpaymentStatus,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int subscriptionId;
  int lastpaymentStatus;
  dynamic createdAt;
  DateTime updatedAt;

  factory LastPaymentStatus.fromJson(Map<String, dynamic> json) =>
      LastPaymentStatus(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        lastpaymentStatus: json["lastpaymentStatus"] == null
            ? null
            : json["lastpaymentStatus"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "lastpaymentStatus":
            lastpaymentStatus == null ? null : lastpaymentStatus,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class LastPaymentAndDate {
  LastPaymentAndDate({
    this.id,
    this.branchId,
    this.voucherNumber,
    this.userId,
    this.sheduledDateId,
    this.subscriptionId,
    this.gram,
    this.amount,
    this.taransactionId,
    this.paymentDate,
    this.paidBy,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int branchId;
  String voucherNumber;
  int userId;
  int sheduledDateId;
  int subscriptionId;
  String gram;
  String amount;
  String taransactionId;
  DateTime paymentDate;
  int paidBy;
  int paymentMethod;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory LastPaymentAndDate.fromJson(Map<String, dynamic> json) =>
      LastPaymentAndDate(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        voucherNumber:
            json["voucherNumber"] == null ? null : json["voucherNumber"],
        userId: json["UserId"] == null ? null : json["UserId"],
        sheduledDateId:
            json["SheduledDateId"] == null ? null : json["SheduledDateId"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        gram: json["gram"] == null ? null : json["gram"],
        amount: json["amount"] == null ? null : json["amount"],
        taransactionId:
            json["taransactionId"] == null ? null : json["taransactionId"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
        paidBy: json["paidBy"] == null ? null : json["paidBy"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "voucherNumber": voucherNumber == null ? null : voucherNumber,
        "UserId": userId == null ? null : userId,
        "SheduledDateId": sheduledDateId == null ? null : sheduledDateId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "gram": gram == null ? null : gram,
        "amount": amount == null ? null : amount,
        "taransactionId": taransactionId == null ? null : taransactionId,
        "paymentDate": paymentDate == null
            ? null
            : "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "paidBy": paidBy == null ? null : paidBy,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class SheduledList {
  SheduledList({
    this.id,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.subscriptionId,
    this.paymentStartDates,
    this.paymentEndDates,
    this.order,
    this.status,
    this.upiStatus,
    this.createdAt,
    this.updatedAt,
  });
  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  int subscriptionId;
  DateTime paymentStartDates;
  DateTime paymentEndDates;
  int order;
  int status;
  var upiStatus;
  DateTime createdAt;
  DateTime updatedAt;
  factory SheduledList.fromJson(Map<String, dynamic> json) => SheduledList(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId:
            json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        paymentStartDates: json["PaymentStartDates"] == null
            ? null
            : DateTime.parse(json["PaymentStartDates"]),
        paymentEndDates: json["PaymentEndDates"] == null
            ? null
            : DateTime.parse(json["PaymentEndDates"]),
        order: json["order"] == null ? null : json["order"],
        status: json["status"] == null ? null : json["status"],
        upiStatus: json["upi_status"] == null ? null : json["upi_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "PaymentStartDates": paymentStartDates == null
            ? null
            : "${paymentStartDates.year.toString().padLeft(4, '0')}-${paymentStartDates.month.toString().padLeft(2, '0')}-${paymentStartDates.day.toString().padLeft(2, '0')}",
        "PaymentEndDates": paymentEndDates == null
            ? null
            : "${paymentEndDates.year.toString().padLeft(4, '0')}-${paymentEndDates.month.toString().padLeft(2, '0')}-${paymentEndDates.day.toString().padLeft(2, '0')}",
        "order": order == null ? null : order,
        "upi_status": upiStatus == null ? null : upiStatus,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class LastDate {
  LastDate({
    this.id,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.subscriptionId,
    this.paymentStartDates,
    this.paymentEndDates,
    this.order,
    this.status,
    this.upiStatus,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  int subscriptionId;
  DateTime paymentStartDates;
  DateTime paymentEndDates;
  int order;
  int status;
  var upiStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory LastDate.fromJson(Map<String, dynamic> json) => LastDate(
        id: json["id"] == null ? null : json["id"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId:
            json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        paymentStartDates: json["PaymentStartDates"] == null
            ? null
            : DateTime.parse(json["PaymentStartDates"]),
        paymentEndDates: json["PaymentEndDates"] == null
            ? null
            : DateTime.parse(json["PaymentEndDates"]),
        order: json["order"] == null ? null : json["order"],
        status: json["status"] == null ? null : json["status"],
        upiStatus: json["upi_status"] == null ? null : json["upi_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "UserId": userId == null ? null : userId,
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "PaymentStartDates": paymentStartDates == null
            ? null
            : "${paymentStartDates.year.toString().padLeft(4, '0')}-${paymentStartDates.month.toString().padLeft(2, '0')}-${paymentStartDates.day.toString().padLeft(2, '0')}",
        "PaymentEndDates": paymentEndDates == null
            ? null
            : "${paymentEndDates.year.toString().padLeft(4, '0')}-${paymentEndDates.month.toString().padLeft(2, '0')}-${paymentEndDates.day.toString().padLeft(2, '0')}",
        "order": order == null ? null : order,
        "upi_status": upiStatus == null ? null : upiStatus,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Subs {
  Subs({
    this.id,
    this.userId,
    this.branchId,
    this.schemeId,
    this.schemeAmountId,
    this.startDate,
    this.endDate,
    this.subscriptionType,
    this.schemeType,
    this.userSchemeName,
    this.dateCheck,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  int id;
  var branchId;
  int userId;
  int schemeId;
  int schemeAmountId;
  DateTime startDate;
  dynamic userSchemeName;
  dynamic endDate;
  int subscriptionType;
  int schemeType;
  DateTime dateCheck;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subs.fromJson(Map<String, dynamic> json) => Subs(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        userId: json["UserId"] == null ? null : json["UserId"],
        schemeId: json["SchemeId"] == null ? null : json["SchemeId"],
        schemeAmountId:
            json["SchemeAmountId"] == null ? null : json["SchemeAmountId"],
        userSchemeName: json["user_scheme_name"],
        startDate: json["StartDate"] == null
            ? null
            : DateTime.parse(json["StartDate"]),
        endDate: json["EndDate"],
        subscriptionType: json["subscription_type"] == null
            ? null
            : json["subscription_type"],
        schemeType: json["scheme_type"] == null ? null : json["scheme_type"],
        dateCheck: json["date_check"] == null
            ? null
            : DateTime.parse(json["date_check"]),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "UserId": userId == null ? null : userId,
        "SchemeId": schemeId == null ? null : schemeId,
        "SchemeAmountId": schemeAmountId == null ? null : schemeAmountId,
        "StartDate": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "EndDate": endDate,
        "subscription_type": subscriptionType == null ? null : subscriptionType,
        "scheme_type": schemeType == null ? null : schemeType,
        "date_check": dateCheck == null
            ? null
            : "${dateCheck.year.toString().padLeft(4, '0')}-${dateCheck.month.toString().padLeft(2, '0')}-${dateCheck.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "user_scheme_name": userSchemeName,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Termsandcondtion {
  Termsandcondtion({
    this.id,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  int id;
  String description;
  dynamic createdAt;
  dynamic updatedAt;
  factory Termsandcondtion.fromJson(Map<String, dynamic> json) =>
      Termsandcondtion(
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

class Versions {
  Versions({
    this.android,
    this.ios,
  });
  int android;
  int ios;
  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        android: json["android"] == null ? null : json["android"],
        ios: json["ios"] == null ? null : json["ios"],
      );
  Map<String, dynamic> toJson() => {
        "android": android == null ? null : android,
        "ios": ios == null ? null : ios,
      };
}
