import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/wholewalletmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Wholewalletservice {
  static Future<Wholewalletmodel> postService() async {
    try {
      var url = ApiEndPoints.wallet;
      //  var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'UserId': await getSavedObject("userid")
        //await getSavedObject("userid"),
      });
      Response response = await ApiService.postData(url, formData);
      Wholewalletmodel requests = Wholewalletmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
