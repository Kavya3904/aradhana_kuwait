import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Paymentdetailsmodel.dart';
import 'package:aradhana/model/Recepitmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Paymentdetailsservice {
  static Future<Paymentdetailsmodel> postService(Map data) async {
    try {
      var url = ApiEndPoints.paymentList;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Paymentdetailsmodel requests =
          Paymentdetailsmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Recepitmodel> paymentDetails(Map data) async {
    try {
      var url = ApiEndPoints.paymentDetails;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'SheduledDateId': data['SheduledDateId'],
        'UserId': data['UserId'],
        'subscriptionId': data['subscriptionId']
      });
      print("``````````````````formData``````````````````");
      print(formData);
      Response response = await ApiService.postData(url, formData);
      print("````````````response.data````````````");
      print(response.data);
      print("````````````response.data````````````");

      Recepitmodel requests = Recepitmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
