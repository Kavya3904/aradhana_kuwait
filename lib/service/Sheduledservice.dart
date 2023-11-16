import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Sheduledservice {
  static Future<Sheduledmodel> postService(Map data) async {
    try {
      var url = ApiEndPoints.sheduledList;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      Map details = {
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      };
      print("``````````details``````````");
      print(details);
      FormData formData = FormData.fromMap({
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);

      Sheduledmodel requests = Sheduledmodel.fromJson(response.data);
      await saveObject("terms", requests.data.termsandcondtion.description);
      await saveObject("refers", requests.data.referalId.elementAt(0));
      await saveObject('branch', requests.data.subs.branchId);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
