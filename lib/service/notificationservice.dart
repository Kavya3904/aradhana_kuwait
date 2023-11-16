import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Notificationmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Notificationservice {
  static Future<NotificationModel> notification() async {
    try {
      var url = ApiEndPoints.notification;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'UserId': await getSavedObject('userid'),
      });
      //  print(data);
      Response response = await dioInstance.post(url, data: formData);
      NotificationModel requests = NotificationModel.fromJson(response.data);
      //  showToast(requests.message);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
