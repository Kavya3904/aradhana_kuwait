import 'package:aradhana/model/SchemeListModel.dart';
import 'package:aradhana/model/schemeAmountListmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Schemelistservice {
  static Future<SchemeListmodel> getScheme() async {
    try {
      var url = ApiEndPoints.schemeList;
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      SchemeListmodel requests = SchemeListmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<SchemeAmountListmodel> schemeAmount(String id) async {
    try {
      var url = ApiEndPoints.schemeAmount + id;
      print(id);
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      SchemeAmountListmodel requests =
          SchemeAmountListmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
