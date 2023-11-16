import 'dart:developer';

import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

import '../model/SaveSchemeModel.dart';

class likePostService {
  static Future<SaveSchemeModel> like(Map data) async {
    try {
      var url = ApiEndPoints.likePost;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'postId': data['postId'],
        'check': data['chk'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      log(response.data.toString());

      SaveSchemeModel requests = SaveSchemeModel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
