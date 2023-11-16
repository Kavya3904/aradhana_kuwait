import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/BranchListModel.dart';
import 'package:aradhana/model/Dashboardmodel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/service/branchservice.dart';
import 'package:dio/dio.dart';

List branchid = [];
var branchhh;

class Dashbordservice {
  static Future<Dashboardmodel> getDashboard() async {
    BranchListModel branchs = await Branchservice.getBranch();

    branchid = branchs.data.branches.map((e) => e.id).toList();

    branchhh = branchid[0];
    print(branchhh);
    try {
      var branchid = await getSavedObject('branch') ?? "2";
      print("'''''''''''branchid'''''''''''");
      print(branchid);
      print("'''''''''''branchid'''''''''''");
      var url = "dashboard/" + branchhh.toString();
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );

      Response response = await Dio().get(ApiConfigs.API_URL + url);
      Dashboardmodel requests = Dashboardmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
