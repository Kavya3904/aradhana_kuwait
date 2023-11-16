import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';

class termsCondition extends StatefulWidget {
  static String routeName = "/termsCondition";

  const termsCondition({Key key}) : super(key: key);

  @override
  State<termsCondition> createState() => _termsConditionState();
}

class _termsConditionState extends State<termsCondition> {
  Sheduledmodel dataa;
  var termsCondition;
  bool load = true;
  @override
  void initState() {
    super.initState();
    getNoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Terms & Conditions", style: appBarTxtStyl),
      ),
      body: load == true
          ? Opacity(opacity: 0)
          : Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12)),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Html(data: termsCondition),
                    ),
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
    );
  }

  getNoti() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };

    try {
      EasyLoading.show(status: 'Loading...');
      Sheduledmodel datas = await Sheduledservice.postService(details);
      setState(() {
        dataa = datas;
        termsCondition = dataa.data.termsandcondtion.description;
        EasyLoading.dismiss();
        load = false;
      });
    } catch (e) {
      setState(() {});
      EasyLoading.dismiss();
      Navigator.pop(context);
      print(e);
    }
    setState(() {});
  }
}
