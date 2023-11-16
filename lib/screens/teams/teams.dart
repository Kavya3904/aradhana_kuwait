import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:random_string/random_string.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../Util/Utils.dart';
import '../../model/teamModel.dart';
import '../../service/teamservice.dart';

class Teams extends StatefulWidget {
  static String routeName = "/Teams";
  const Teams({Key key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
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

  TeamModel data;

  Future<TeamModel> getPaymentdetails() async {
    print("````````````````````");
    TeamModel datas;
    int userid;
    try {
      userid = await getSavedObject("userid");
      //showLoading(context);
      EasyLoading.show(status: 'Loading...');
      print(userid);
      datas = await Teamservice.getTeam();
      print(datas);
      EasyLoading.dismiss();
      //  totalpayment = data.data.sheduledList.length;
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      return datas;
      //  Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Management", style: appBarTxtStyl),
        ),
        body: FutureBuilder<TeamModel>(
          future: getPaymentdetails(), // async work
          builder: (BuildContext context, AsyncSnapshot<TeamModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}', style: size15_800W);
                } else {
                  return snapshot.data.data.bankDetails.isEmpty
                      ? const Center(
                          child: Text(
                            "No members to show currently!",
                            style: size15_800,
                          ),
                        )
                      : Scrollbar(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data.data.bankDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20, top: 5),
                                  child: Card(
                                    elevation: 5,
                                    color: Color(
                                        colorArr[int.parse(randomNumeric(1))]),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            snapshot.data.data.bankDetails
                                                        .elementAt(index)
                                                        .image !=
                                                    null
                                                ? Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(ApiConfigs
                                                                    .imageurls +
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bankDetails
                                                                    .elementAt(
                                                                        index)
                                                                    .image),
                                                            fit: BoxFit.cover)),
                                                  )
                                                : Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Image.asset(
                                                        "assets/fixedAssets/personcirle.png")),
                                            const VerticalDivider(),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data.data.bankDetails
                                                        .elementAt(index)
                                                        .name,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                  snapshot.data.data.bankDetails
                                                              .elementAt(index)
                                                              .designation !=
                                                          null
                                                      ? Text(
                                                          snapshot.data.data
                                                              .bankDetails
                                                              .elementAt(index)
                                                              .designation,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: HexColor(
                                                                "313131"),
                                                          ),
                                                        )
                                                      : const Opacity(
                                                          opacity: 0),
                                                  Text(
                                                    snapshot
                                                        .data.data.bankDetails
                                                        .elementAt(index)
                                                        .phone,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: HexColor("313131"),
                                                    ),
                                                  ),
                                                  h(5),
                                                  const Divider(thickness: 1),
                                                  IntrinsicHeight(
                                                      child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: (() {
                                                          setState(() {
                                                            _makePhoneCall('tel:' +
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bankDetails
                                                                    .elementAt(
                                                                        index)
                                                                    .phone);
                                                          });
                                                        }),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              child: Image.asset(
                                                                  "assets/fixedAssets/telephone.png",
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final link =
                                                              WhatsAppUnilink(
                                                            phoneNumber:
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bankDetails
                                                                    .elementAt(
                                                                        index)
                                                                    .phone,
                                                            text: "",
                                                          );
                                                          await launch('$link');
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              child: Image.asset(
                                                                  "assets/fixedAssets/whatsapp.png")),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }));
                }
            }
          },
        ));
  }
}
