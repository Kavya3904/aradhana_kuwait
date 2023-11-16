import 'package:aradhana/model/Agentpendingmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Pendingpaymentservice {
  static Future<Agentpendingmodel> getpendingpayment() async {
    try {
      var url = ApiEndPoints.agentPaymentToAdmin;
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      Agentpendingmodel requests = Agentpendingmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
