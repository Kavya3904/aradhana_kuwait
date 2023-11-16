import 'dart:convert';

import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: ApiConfigs.API_URL,

  // connectTimeout: 5000,
  // receiveTimeout: 3000,
);
Dio dioInstance = new Dio(options);

class ApiService {
  String firebasetoken;
  static Future<Response> getData(String url, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> _data = data;
      // var user = await getSavedObject("@user");

      // if (user != null) {
      //   UserModel _user = UserModel.fromJson(user);
      //   _data = {...data, "sessionId": _user.sessionId};
      // }
      print(_data);
      //  dioInstance.options.headers['content-Type'] = 'application/json';
      dioInstance.options.headers["Authorization"] =
          "Bearer " + await getSavedObject("token");
      print("Bearer " + await getSavedObject("token"));

      /////
      Response response = await dioInstance.get(url, queryParameters: _data);
      print(response);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Response> postData(
    String url,
    dynamic data,
  ) async {
    try {
//    dioInstance.interceptors.add(InterceptorsWrapper(
//  onResponse: (Response response) async {
// // Write your response logic

//       return response; // continue
//     },

//        onError: (error) async {
//           if (error.response?.statusCode == 302 ||
//               error.response?.statusCode == 302) {
//                 var urls=url;
//                 var dyamics=data;
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     // NotificationSettings settings = await messaging.requestPermission(
//     //   alert: true,
//     //   announcement: false,
//     //   badge: true,
//     //   carPlay: false,
//     //   criticalAlert: false,
//     //   provisional: false,
//     //   sound: true,
//     // );

//     // print('User granted permission: ${settings.authorizationStatus}');
//    String firebasetoken = await messaging.getToken();
//    String mobilenumber=  await getSavedObject("phone");
//       Map b = {"phone": mobilenumber, "FcmToken": firebasetoken};
//       print("Its working yeahhhh.............................................");
//       print(firebasetoken);
//       print(mobilenumber);
//       print(firebasetoken);
//       EasyLoading.show(status: 'Loading...');
//       //    showLoading(context);
//   await UserService.login(b);
//       EasyLoading.dismiss();
//      postData(urls,dyamics);
//             //  await refreshToken();
//            //   return _retry(error.request);
//             }
//             return options;
//         }));
      dioInstance.options.headers["Authorization"] =
          "Bearer " + await getSavedObject("token");
      Response response = await dioInstance.post(url, data: data);
      return response;
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        if (e.response != null) {
          try {
            var errr = json.decode(e.response.toString());
            throw new Exception(errr);
          } catch (err) {
            throw e;
          }
        }
        throw e;
      } else {
        throw e;
      }
    }
  }
}
