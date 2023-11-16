import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/paymentmodel.dart';
import 'package:aradhana/model/userpaymodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Paymentservice {
  static Future<Paymentmodel> postPay(Map data) async {
    try {
      print("````paymenttt````");
      print(ApiEndPoints.payment);
      var url = ApiEndPoints.payment;
      FormData formData = FormData.fromMap({
        'UserId': data['UserId'],
        'SheduledDateId': data['SheduledDateId'],
        'gram': data['gram'],
        'amount': data['amount'],
        'taransactionId': data['taransactionId'],
        'subscriptionId': data['subscriptionId'],
        'paidBy': data['paidBy']
      });
      Response response = await ApiService.postData(url, formData);
      Paymentmodel requests = Paymentmodel.fromJson(response.data);

      showToast(requests.message);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Userpaymodel> userpay(Map data) async {
    try {
      var url = ApiEndPoints.uPIPayment;
      FormData formData = FormData.fromMap({
        'UserId': data['UserId'],
        'SheduledDateId': data['SheduledDateId'],
        'gram': data['gram'],
        'amount': data['amount'],
        'taransactionId': data['taransactionId'],
        'subscriptionId': data['subscriptionId'],
        'payment_method': data['payment_method'],
        'paidBy': data['paidBy'],
        if (data['screenshot'] != null)
          'screenshot': await MultipartFile.fromFile('${data['screenshot']}',
              filename: 'payment.png')
      });
      Response response = await ApiService.postData(url, formData);
      Userpaymodel requests = Userpaymodel.fromJson(response.data);
      showToast(requests.message);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
