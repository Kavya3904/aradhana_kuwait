import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:dio/dio.dart';

import '../model/teamModel.dart';
import '../screens/Config/DioInstance.dart';

class Teamservice {
  static Future<TeamModel> getTeam() async {
    try {
      var url = ApiEndPoints.team;
      Response response = await dioInstance.get(url);
      print(response.data);
      TeamModel requests = TeamModel.fromJson(response.data);
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
