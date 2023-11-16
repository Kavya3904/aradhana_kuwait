import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Registrationmodel.dart';
import 'package:aradhana/model/agentregisterationmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Registrationservice {
  static Future<Registrationmodel> getRegistration(Map data) async {
    try {
      var url = ApiEndPoints.register;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        'dob': data['dob'],
        'branchId': data['branchId'],
        'country': data['country'],
        'district': data['district'],
        'referalId': data['referalId'],
        // 'FcmToken': data['FcmToken'],
      });
      print(data);
      Response response = await dioInstance.post(url, data: formData);

      if (response.statusCode == 200) {
        Registrationmodel requests = Registrationmodel.fromJson(response.data);

        showToast(requests.message);

        if (requests.message.compareTo("You are Registered Successfully.") ==
            0) {
          await saveObject("name", data['name']);
          await saveObject("userid", requests.data.userId);
          await saveObject("Email", data['email']);
          await saveObject("token", requests.data.token);
          await saveObject("roleid", requests.data.roleId);
          await saveObject("phone", data['phone']);
          await saveObject('branch', data['branchId']);
          return requests;
        } else {
          //return requests;
          //EasyLoading.dismiss();
          throw "Please contact admin";
        }
      }
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      EasyLoading.dismiss();

      throw e;
    }
  }

  static Future<Agentregisterationmodel> getagentRegistration(Map data) async {
    try {
      var url = ApiEndPoints.agentUserRegistrastion;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        'address': data['address'],
        'dob': data['dob'],
        'nominee': data['nominee'],
        'nominee_relation': data['nominee_relation'],
        // 'pincode': data['pincode'],
        'branchId': data['branchId'],
        'nominee_phone': data['nominee_phone'],
        'country': data['country'],
        // 'state': data['state'],
        'district': data['district'],
        'referalId': data['referalId'],
        // 'adhaarcard': data['adhaarcard'],
        // 'pancard': data['pancard'],
        'agentId': await getSavedObject("userid"),
        // if (data['adhar'] != null)
        //   'adhar': await MultipartFile.fromFile('${data['adhar']}',
        //       filename: 'identification.png')
      });
      //  print(data);
      Response response = await dioInstance.post(url, data: formData);

      Agentregisterationmodel requests =
          Agentregisterationmodel.fromJson(response.data);
      showToast(requests.message);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
