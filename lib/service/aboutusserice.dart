import 'package:aradhana/model/Aboutusmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Aboutusservice {
  static Future<Aboutusmodel> getAboutus() async {
    try {
      var url = ApiEndPoints.aboutUs;

      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      Aboutusmodel requests = Aboutusmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
