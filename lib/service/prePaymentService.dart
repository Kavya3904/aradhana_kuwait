import 'dart:developer';

import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/prePaymentModel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class prePaymentService {
  static Future<PrePaymentModel> prepay(Map data) async {
    try {
      var url = ApiEndPoints.prePayment;
      var brnchId = await getSavedObject("branch");
      FormData formData = FormData.fromMap({
        'branchId': brnchId.toString(),
        'UserId': data['UserId'],
        'SheduledDateId': data['scheduleddateId'],
        'subscriptionId': data['subscriptionId'],
        'gram': data['gram'],
        'amount': data['amount'],
        'status': "0",
        'OrderId': data['orderId'].toString(),
      });
      Response response = await ApiService.postData(url, formData);

      log(response.data.toString());

      PrePaymentModel requests = PrePaymentModel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      throw e;
    }
  }
}
