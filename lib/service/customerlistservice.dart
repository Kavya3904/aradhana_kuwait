import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Nextpaymentcustomerlistmodel.dart';
import 'package:aradhana/model/agentlistmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Customerlistservice {
  static Future<Agentcustomermodel> getCustomerlist() async {
    try {
      var url = ApiEndPoints.agentCustomerList;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'agentId': await getSavedObject("userid")
        //await getSavedObject("userid"),
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Agentcustomermodel requests = Agentcustomermodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Nextpaymentcustomerlistmodel>
      getCustomernextpaymnetlist() async {
    try {
      var url = ApiEndPoints.agentCustomerListLive;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'agentId': await getSavedObject("userid")
        //await getSavedObject("userid"),
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Nextpaymentcustomerlistmodel requests =
          Nextpaymentcustomerlistmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
