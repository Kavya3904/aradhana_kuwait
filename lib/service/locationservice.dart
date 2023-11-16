import 'package:aradhana/model/Countymodel.dart';
import 'package:aradhana/model/districtmodel.dart';
import 'package:aradhana/model/statemodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Locationservice {
  static Future<Countrymodel> getCountry(int branchid) async {
    try {
      var url = ApiEndPoints.country;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      //  print(data);
      Response response =
          await dioInstance.get(url + "/" + branchid.toString());
      Countrymodel requests = Countrymodel.fromJson(response.data);
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Statemodel> getState(String id) async {
    try {
      var url = ApiEndPoints.states + id;
      Response response = await dioInstance.get(url);
      Statemodel requests = Statemodel.fromJson(response.data);
      print(requests.message);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Districtmodel> getDistrict(String id) async {
    try {
      var url = ApiEndPoints.district + id;
      Response response = await dioInstance.get(url);
      Districtmodel requests = Districtmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
