import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/model/Notificationmodel.dart';
import 'package:aradhana/service/notificationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  static String routeName = "/Notification";
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  List colorArr = [
    0xffDAFFD7,
    0xffD1F8F7,
    0xffDCD7FF,
    0xffFFE1E1,
    0xffFFDDD2,
    0xffCDF0EA,
    0xffD7C0AE,
    0xff90C8AC,
    0xffFAF4B7,
    0xffB1BCE6,
  ];
  NotificationModel data = new NotificationModel();

  @override
  void initState() {
    super.initState();
    getnoification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title: Text("Notifications", style: appBarTxtStyl),
      ),
      body: data.data != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: data.data.notification.isEmpty
                        ? Center(
                            child: Text(
                            "No Notifications",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ))
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10),
                            child: ListView.separated(
                                separatorBuilder: (context, index) => h(15),
                                shrinkWrap: true,
                                itemCount: data.data.notification.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return _design2(index);
                                }),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )
          : Container(),
    );
  }

  Future<void> getnoification() async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      NotificationModel datas = await Notificationservice.notification();
      EasyLoading.dismiss();
      setState(() {
        data = datas;
      });

      //  Navigator.of(context).pop(true);
      // showLoading(context);
      // setState(() {
      //   EasyLoading.dismiss();
      //   data = datas;
      //   print(data);
      //   //  test();
      // });
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  _design2(index) {
    return Stack(
      children: [
        Row(
          children: [
            Container(height: 80, width: 8, color: accentClr),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Image.asset("assets/fixedAssets/bellnotification.png",
                            height: 40),
                        VerticalDivider(color: Colors.black54),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.data.notification.elementAt(index).title,
                                style: size12_600),
                            Text(
                                data.data.notification
                                    .elementAt(index)
                                    .description,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lato')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: Text(
              DateFormat('dd  MMM, yyyy').format(DateTime.parse(data
                  .data.notification
                  .elementAt(index)
                  .createdAt
                  .toString())),
              style: font(9, Colors.black54, FontWeight.w400)),
          bottom: 10,
          right: 10,
        ),
      ],
    );
  }
}
