import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/agentprofileviewmodel.dart';
import 'package:aradhana/model/profileeditmodel.dart';
import 'package:aradhana/model/profileeditpostmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Schemelistgetprofile {
  static Future<Profileditmodel> getprofile() async {
    try {
      int userid;
      int role = await getSavedObject("roleid");
      if (role == 3) {
        userid = await getSavedObject("customerid");
      } else {
        userid = await getSavedObject("userid");
      }
      var url = ApiEndPoints.profile + userid.toString();
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      Profileditmodel requests = Profileditmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Agentprofileviewmodel> getprofileagent() async {
    try {
      int userid = await getSavedObject("userid");
      var url = ApiEndPoints.agentprofile + userid.toString();
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await ApiService.getData(url, data);
      print(response.data);
      Agentprofileviewmodel requests =
          Agentprofileviewmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Profileditpostmodel> postprofileEdit(Map data) async {
    try {
      var url = ApiEndPoints.editProfile;

      int userid;
      int role = await getSavedObject("roleid");
      if (role == 3) {
        userid = await getSavedObject("customerid");
      } else {
        userid = await getSavedObject("userid");
      }

      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'UserId': userid,
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        'address': data['address'],
        'dob': data['dob'],
        'nominee': data['nominee'],
        'nominee_phone': data['nominee_phone'],
        'nominee_relation': data['nominee_relation'],
        'pincode': data['pincode'],
        'country': data['country'],
        'state': data['state'],
        'district': data['district'],
        'referalId': data['referalId'],
        'adhaarcard': data['adhaarcard'],
        'pancard': data['pancard'],
      });
      //  print(data);
      Response response = await dioInstance.post(url, data: formData);
      Profileditpostmodel requests =
          Profileditpostmodel.fromJson(response.data);
      showToast(requests.message);
      await saveObject("name", data['name']);
      // await saveObject("userid", requests.data.userId);
      // await saveObject("Email",  data['email']);
      // await saveObject("token", requests.data.token);
      // await saveObject("roleid", requests.data.roleId);
      // await saveObject("phone", data['phone']);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Profileditpostmodel> postprofileagentEdit(Map data) async {
    try {
      var url = ApiEndPoints.agenteditProfile;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'UserId': await getSavedObject('userid'),
        'agentName': data['agentName'],
        'email': data['email'],
        'phone': data['phone'],
        'address': data['address'],
        'adhaar': data['adhaar'],
        'panNumber': data['pancard'],
      });
      //  print(data);
      Response response = await dioInstance.post(url, data: formData);
      Profileditpostmodel requests =
          Profileditpostmodel.fromJson(response.data);
      showToast(requests.message);
      await saveObject("name", data['name']);
      // await saveObject("userid", requests.data.userId);
      // await saveObject("Email",  data['email']);
      // await saveObject("token", requests.data.token);
      // await saveObject("roleid", requests.data.roleId);
      // await saveObject("phone", data['phone']);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
