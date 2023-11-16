import 'package:aradhana/model/Subscriptionlistmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Schemelistgetservice {
  static Future<Subscriptionlistmodel> getScheme(int userid) async {
    try {
      var url = ApiEndPoints.subscriptionList + userid.toString();

      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      Subscriptionlistmodel requests =
          Subscriptionlistmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
