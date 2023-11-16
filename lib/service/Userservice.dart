import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Usermodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class UserService {
  static Future<Usermodel> login(Map data) async {
    Usermodel requests;
    try {
      var url = ApiEndPoints.login;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap(
        {
          "phone": data['phone'],
          // "phone":data['9562044472'],
          "FcmToken": data['FcmToken']
        },
      );
      //  print(data);
      Response response = await dioInstance.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        Usermodel requests = Usermodel.fromJson(response.data);
        await saveObject("name", requests.data.userName);

        await saveObject("userid", requests.data.userId);
        await saveObject("Email", requests.data.email);
        await saveObject("roleid", requests.data.roleId);
        await saveObject("phone", data['phone']);
        await saveObject("token", requests.data.token);
        await saveObject('branch', requests.data.branchId);
        if (requests.data.roleId == 3) {
          await saveObject("referalId", requests.data.referalId);
        }
        return requests;
      } else {
        return requests;
      }

      // await savename("name", loginResponse.data.userName);

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // static Future<Usermodel> login(String phone, String password) async {
  //   try {
  //     print("LOGIN");
  //     var url = ApiEndPoints.clientLogin;
  //     Response response = await dioInstance.get(
  //       url,
  //       queryParameters: {"uname": username, "pwd": password},
  //     );
  //     LoginResponse loginResponse = loginResponseFromJson(response.toString());

  //     return loginResponse.data;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
