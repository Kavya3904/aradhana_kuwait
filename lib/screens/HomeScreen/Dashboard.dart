import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/newBottomDrawer.dart';
import 'package:aradhana/model/Dashboardmodel.dart' as model;
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/service/Dashboardservice.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:package_info/package_info.dart';
import 'package:readmore/readmore.dart';

import '../../Util/Utils.dart';
import '../../model/Sheduledmodel.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/Dashboard";
  const Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> imageList = [];
  bool updown = false;
  String gram;
  String change;
  List<String> imageList1 = [];
  bool loaded = false;
  model.Dashboardmodel data;

  Sheduledmodel datas = new Sheduledmodel();
  bool vis = false;
  int totalpayment = 0;
  bool ios = true;
  int totalpayed = 0;
  var paymentpendingid;
  var paymentdate;
  var schemeId;
  String upistatus = "0";
  var schemeAmountId;
  var paymentStartDates;
  var paymentEndDates;
  int nums = 0;
  PackageInfo packageInfo;
  int nextpayment = 0;
  int role;
  Sheduledmodel dataa;
  var termsCondition;
  var notiCount;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getrole() async {
    role = await getSavedObject("roleid");

    //number= await getSavedObject("phone");
  }

  getNoti() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };
    role = await getSavedObject("roleid");
    try {
      EasyLoading.show(status: 'Loading...');
      Sheduledmodel datas = await Sheduledservice.postService(details);
      setState(() {
        dataa = datas;
        termsCondition = dataa.data.termsandcondtion.description;
        notiCount = dataa.data.notificationCount;
      });
    } catch (e) {
      setState(() {});
      EasyLoading.dismiss();
      Navigator.pop(context);
    }
    setState(() {
      role;
    });
  }

  void getProfile() async {
    String buildNumber = "11";
    totalpayed = 0;
    vis = false;
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };

    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Sheduledmodel datas = await Sheduledservice.postService(details);

      PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        buildNumber = packageInfo.buildNumber;

        if (datas.data.status.toString().compareTo("203") == 0) {
          Navigator.pushReplacementNamed(
            context,
            SelectScheme.routeName,
          );
        }

        ///   print(packageInfo.version);
        if (Platform.isAndroid) {
          if (datas.data.versions.android > int.parse(buildNumber)) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Update', (Route<dynamic> route) => false);
          }
          // Android-specific code
        } else if (Platform.isIOS) {
          if (datas.data.versions.ios > int.parse(buildNumber)) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Update', (Route<dynamic> route) => false);
          }
          // iOS-specific code
        }
      });

      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();
      setState(() {
        datas = datas;
        //  test();
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();

      //  Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            appBar: AppBar(
              leading: role == 2 || role == 4
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: IconButton(
                            icon: Icon(Icons.sort, size: 30),
                            onPressed: () {
                              newDrawerr(context, termsCondition);
                              // Scaffold.of(context).openDrawer();
                            }),
                      ),
                    )
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ),
              actions: [
                role == 2 || role == 4
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Notifications.routeName,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Stack(
                                children: [
                                  Container(
                                    child: Icon(Icons.notifications, size: 30),
                                  ),
                                  notiCount == null
                                      ? Opacity(opacity: 0)
                                      : notiCount == 0
                                          ? Container()
                                          : Container(
                                              width: 30,
                                              height: 30,
                                              alignment: Alignment.topRight,
                                              margin: EdgeInsets.only(top: 0),
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffc32c37),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Center(
                                                    child: Text(
                                                      notiCount.toString(),
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
              title: Image.asset("assets/logoOnly.png", height: 40),
              centerTitle: true,
            ),
            //  backgroundColor: HexColor("720755"),
            // bottomNavigationBar: Container(
            //   color: HexColor("720755"),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: TextButton(
            //       child: Text(
            //         "Scheme Details",
            //         style: TextStyle(
            //             color: Colors.white, fontWeight: FontWeight.w500),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context)
            //             .pushReplacementNamed(HomeTabs.routeName);
            //       },
            //     ),
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3 + 110,
                        child: Stack(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                  // onTap: () async {
                                  //   if (await canLaunch(
                                  //       "https://www.proaims.in/")) {
                                  //     await launch(
                                  //         "https://www.proaims.in/");
                                  //   } else {
                                  //     throw 'Could not launch "https://www.proaims.in/';
                                  //   }
                                  // },
                                  child: ClipRRect(
                                    child: GFCarousel(
                                      viewportFraction: 1.0,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      activeIndicator: Colors.white,
                                      passiveIndicator: Colors.black,
                                      hasPagination: true,
                                      autoPlay: true,
                                      items: imageList.map(
                                        (item) {
                                          return Container(
                                            margin: EdgeInsets.all(0.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                              child: Image.network(
                                                  ApiConfigs.imageurls + item,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      //   onPageChanged: (index) {
                                      //     setState(() {
                                      //       index;
                                      //     });
                                      //   },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Container(
                                  height: 130,
                                  child: Stack(
                                    children: [
                                      Align(
                                          child: Container(
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      goldenUpDownGradient),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text("1 Gram",
                                                              style:
                                                                  size14_400),
                                                          h(5),
                                                          Text(
                                                              rs +
                                                                  data.data
                                                                      .todayRate.toString(),
                                                              style:
                                                                  goldrateText)
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text("8 Gram",
                                                              style:
                                                                  size14_400),
                                                          h(5),
                                                          Text(
                                                              rs +
                                                                  gram
                                                                      .toString(),
                                                              style: goldrateText)
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                              updown
                                                                  ? "Up"
                                                                  : "Down",
                                                              style:
                                                                  size14_400),
                                                          h(5),
                                                          Text(
                                                              rs +
                                                                  change
                                                                      .toString()
                                                                      .split(
                                                                          ".")[0],
                                                              style: goldrateText)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: appbarClr,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0,
                                                right: 18,
                                                top: 4,
                                                bottom: 4),
                                            child: Text(
                                              "Today's Gold Rate",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      236, 236, 236, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ElevatedButton(
                      //       style: ButtonStyle(
                      //         shape: MaterialStateProperty.all<
                      //                 RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0),
                      //         )),
                      //         padding: MaterialStateProperty.all(
                      //             EdgeInsets.all(12)),
                      //         backgroundColor: MaterialStateProperty.all(
                      //             Color.fromRGBO(167, 116, 27, 1)),
                      //       ),
                      //       child: Text(
                      //         "Scheme Brochure",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //       onPressed: ()
                      //        {
                      //         Navigator.of(context)
                      //             .pushNamed(Brochure.routeName);
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  div,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(storeName, style: size15_800),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GFCarousel(
                      viewportFraction: 1.0,
                      activeIndicator: Colors.white,
                      passiveIndicator: Colors.black,
                      hasPagination: true,
                      autoPlay: true,
                      items: imageList1.map(
                        (item) {
                          return Container(
                            margin: EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network(ApiConfigs.imageurls + item,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: ReadMoreText(
                        data.data.bannerContent.bannerContent.toString(),
                        // data.data.schemeDetails.description.toString(),
                        style: size12_400,
                        trimLines: 2,
                        colorClickableText: Colors.red,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "...Show more",
                        trimExpandedText: ' \nShow less',
                        textAlign: TextAlign.left,
                        moreStyle: font(12, appbarClr, FontWeight.w400),
                        lessStyle: font(12, appbarClr, FontWeight.w400)),
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        //       Navigator.of(context).pushNamed(Brochure.routeName);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor("E8C044"),
                                ),
                                color: inputClr,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Download brochure".toUpperCase(),
                                style: font(
                                    14, Color(0xffE8C044), FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))
        : Opacity(opacity: 0);
  }
  //
  // void pay() async {
  //   var headers = {
  //     razorpayKeyLive: razorpaySecretKeyLive,
  //     'content-type': 'application/json'
  //   };
  //
  //   var request =
  //       http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
  //   request.bodyFields = {
  //     'amount': '',
  //     'currenct': "INR",
  //     'receipt': '',
  //   };
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print(response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  Future<model.Dashboardmodel> getUserDetails() async {
    getProfile();
    getrole();
    getNoti();
    try {
      EasyLoading.show(status: 'Loading...');
      //showLoading(context);
      model.Dashboardmodel datas = await Dashbordservice.getDashboard();
      EasyLoading.dismiss();

      if (datas.success) {
        imageList = datas.data.bannerImage.map((e) => e.bannerImage).toList();
        imageList1 = datas.data.schemeImage.map((e) => e.bannerImage).toList();

        gram = (double.parse(datas.data.todayRate) * 8).toString();

        if (double.parse(datas.data.todayRate) >
            double.parse(datas.data.gramPrevious)) {
          change = ((double.parse(datas.data.todayRate) -
                      double.parse(datas.data.gramPrevious)) *
                  8)
              .toString();
          updown = true;
        } else {
          change = ((double.parse(datas.data.gramPrevious) -
                      double.parse(datas.data.todayRate)) *
                  8)
              .toString();
          updown = false;
        }

        setState(() {
          data = datas;
          loaded = true;
        });
      }
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
