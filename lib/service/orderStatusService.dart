import 'dart:developer';

import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/orderStatusModel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class orderStatusService {
  static Future<OrderStatusModel> statusUpdate(Map data) async {
    try {
      var url = ApiEndPoints.orderStatus;
      FormData formData = FormData.fromMap({
        'status': "1",
        'OrderId': data['orderId'].toString(),
      });
      Response response = await ApiService.postData(url, formData);

      log(response.data.toString());

      OrderStatusModel requests = OrderStatusModel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      throw e;
    }
  }
}
