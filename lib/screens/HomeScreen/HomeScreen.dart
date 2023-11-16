import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/model/paymentmodel.dart';
import 'package:aradhana/screens/HomeScreen/Dashboardhome.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/screens/Paymentsendscreen/Paymentscreen.dart';
import 'package:aradhana/service/Paymentservice.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../model/Subscriptionlistmodel.dart';
import '../../service/Schemelistgetservice.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Sheduledmodel data = new Sheduledmodel();
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
  //String number="";

  final amountController = TextEditingController();
  getrole() async {
    role = await getSavedObject("roleid");
    print(role);
    //number= await getSavedObject("phone");
  }

  // getnot() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');
  //     getProfile();
  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getrole();
    getProfile();
    getdata();
    getScheme();
    // getnot();
  }

  getdata() async {
    int z = await getSavedObject('userid');
    bool b = z == iosUser ? false : true;
    print(b);
    setState(() {
      ios = b;
      print(ios);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final pushNotificationService = PushNotificationService(getProfile);
    // pushNotificationService.initialise();
    //

    return Scaffold(
      //    backgroundColor: HexColor("#720755"),
      body: data.data != null
          ? Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          role == 2 || role == 4
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // color: HexColor("#ffffff")
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: IconButton(
                                        icon: Icon(Icons.menu,
                                            color: HexColor("#720755")),
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        }),
                                  ),
                                )
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                          // : Container(
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: Colors.black),
                          //     child: IconButton(
                          //         icon: Icon(Icons.switch_account,
                          //             color: HexColor("#FFD98D")),
                          //         onPressed: () {
                          //           Navigator.pushReplacementNamed(
                          //             context,
                          //             SelectScheme.routeName,
                          //           );
                          //         }),
                          //   ),

                          Spacer(),
                          role == 2 || role == 4
                              ? InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Notifications.routeName,
                                    );
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.notifications,
                                            color: HexColor("#720755"),
                                            size: 25,
                                          ),
                                        ),
                                        data.data.notificationCount == 0
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
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Center(
                                                      child: Text(
                                                        data.data
                                                            .notificationCount
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),

//                           Container(
//                             child: Stack(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                 shape: BoxShape.circle, color: Colors.black),
//                                   child: IconButton(
//                                       icon: Icon(Icons.notifications,
//                                           color: HexColor("#FFD98D")),
//                                       onPressed: null),
//                                 ),
//  Container(
//         width: 30,
//         height: 30,
//         alignment: Alignment.topRight,
//         margin: EdgeInsets.only(top: 5),
//         child: Container(
//           width: 15,
//           height: 15,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xffc32c37),
//               border: Border.all(color: Colors.white, width: 1)),
//           child: Padding(
//             padding: const EdgeInsets.all(0.0),
//             child: Center(
//               child: Text(
//                data.data.notificationCount.toString(),
//                 style: TextStyle(fontSize: 5),
//               ),
//             ),
//           ),
//         ),
//       ),
//                               ],
//                             ),
//                           ),
                          SizedBox(
                            width: 10,
                          ),

                          role == 4
                              ? Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Dashboardhome.routeName,
                                        );
                                      }),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: HexColor("#A7A7A7"),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              //side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: data.data.schemetype != 1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          HexColor("#832225"),
                                          HexColor("#88151c"),
                                          HexColor("#832225"),
                                          HexColor("#88151c"),

                                          // Colors.indigo,
                                          // Colors.teal,
                                        ],
                                      ),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        // colorFilter: new ColorFilter.mode(
                                        //     Colors.yellow.withOpacity(0.1),
                                        //     BlendMode.dstATop),
                                        image: AssetImage(
                                          'assets/fixedAssets/bn.png',
                                        ),
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        // colorFilter: new ColorFilter.mode(
                                        //     Colors.yellow.withOpacity(0.1),
                                        //     BlendMode.dstATop),
                                        image: AssetImage(
                                          'assets/fixedAssets/bg.png',
                                        ),
                                      ),
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 15),
                                      child: data.data.schemetype != 1
                                          ? Row(
                                              children: [
                                                Text(
                                                  data.data.schemeName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                        "assets/justlogo.png"))
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10,
                                                          bottom: 10,
                                                          top: 10),
                                                  child: Text(
                                                    data.data.schemeName,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                        "assets/justlogo.png"))
                                              ],
                                            ),
                                    ),
                                    data.data.schemetype != 1
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    border: Border.all(
                                                      color: HexColor(
                                                          "#f2cc5e"), //                   <--- border color
                                                      width: 1.4,
                                                    ),
                                                  ),
                                                  child: StepProgressIndicator(
                                                    totalSteps: totalpayment,
                                                    currentStep: totalpayed,
                                                    size: 11,
                                                    padding: 0,
                                                    selectedColor:
                                                        HexColor("#f7D177"),
                                                    unselectedColor:
                                                        Colors.transparent,
                                                    roundedEdges:
                                                        Radius.circular(20),
                                                    selectedGradientColor:
                                                        LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        HexColor("#f7D177"),
                                                        HexColor("#f7D177")
                                                      ],
                                                    ),
                                                    unselectedGradientColor:
                                                        LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.transparent
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                totalpayed.toString() +
                                                    "/" +
                                                    totalpayment.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: HexColor("#f1cb56")),
                                              )
                                            ],
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Column(
                                                    //   children: [
                                                    //     Text("AMOUNT PAID",
                                                    //         style: TextStyle(
                                                    //             fontSize: 14,
                                                    //             color:
                                                    //                 Colors.white)),
                                                    //     Text(
                                                    //         data.data.lastPaymentAndDate !=
                                                    //                 null
                                                    //             ? "₹" +
                                                    //                 data
                                                    //                     .data
                                                    //                     .lastPaymentAndDate
                                                    //                     .amount
                                                    //                     .toString()
                                                    //             : "₹0",
                                                    //         style: TextStyle(
                                                    //             fontSize: 16,
                                                    //             fontWeight:
                                                    //                 FontWeight.bold,
                                                    //             color:
                                                    //                 Colors.white))
                                                    //   ],
                                                    // ),
                                                    //Spacer(),
                                                    Column(
                                                      children: [
                                                        Text("TOTAL AMOUNT",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                            data.data.sumAmount !=
                                                                    null
                                                                ? "₹" +
                                                                    data.data
                                                                        .sumAmount
                                                                        .toString()
                                                                : "₹0",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: HexColor(
                                                                    "#B8E5A3")))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                data.data.lastPaymentAndDate ==
                                                        null
                                                    ? Container()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                            ),
                                                            Text(
                                                                "Last amount paid on " +
                                                                    DateFormat(
                                                                            "dd-MM-yyyy")
                                                                        .format(data
                                                                            .data
                                                                            .lastPaymentAndDate
                                                                            .paymentDate),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                            .grey[
                                                                        300])),
                                                            Text(
                                                                data
                                                                    .data
                                                                    .lastPaymentAndDate
                                                                    .amount
                                                                    .toString()
                                                                    .split(
                                                                        ".")[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            if (data.data.subs
                                                                    .userSchemeName !=
                                                                null)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10.0),
                                                                child: Text(
                                                                    "Scheme Name : " +
                                                                        data
                                                                            .data
                                                                            .subs
                                                                            .userSchemeName
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white)),
                                                              )
                                                          ],
                                                        ),
                                                      )

                                                // Text(
                                                //   "First half of scheme period till " +
                                                //       data.data.subs.dateCheck
                                                //           .toString()
                                                //           .substring(0, 10),
                                                //   style: TextStyle(
                                                //       fontSize: 13,
                                                //       color: Colors.white),
                                                // ),
                                                // ,  SizedBox(
                                                //     height: 15,
                                                //   ),
                                                //   Row(
                                                //     children: [
                                                //       Text(
                                                //           "Payment made on first half ",
                                                //           style: TextStyle(
                                                //               fontSize: 13,
                                                //               color: Colors.white)),
                                                //       Text(
                                                //           "₹" +
                                                //               data.data.halfPaymentSum
                                                //                   .toString(),
                                                //           style: TextStyle(
                                                //               fontSize: 14,
                                                //               fontWeight:
                                                //                   FontWeight.bold,
                                                //               color: Colors.white))
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 15,
                                                // ),
                                                // Text(
                                                //     "Scheme end on " +
                                                //         data.data.lastDate
                                                //             .elementAt(0)
                                                //             .paymentEndDates
                                                //             .toString()
                                                //             .substring(0, 10),
                                                //     style: TextStyle(
                                                //         fontSize: 13,
                                                //         color: Colors.white))
                                              ],
                                            )),
                                    data.data.schemetype != 1
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, bottom: 10),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("TOTAL AMOUNT",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                        "₹ " +
                                                            data.data.sumAmount
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                                Spacer(),
                                                data.data.paymentType == 0
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "Today's Earnings",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white)),
                                                          Text(
                                                              "₹ " +
                                                                  data.data
                                                                      .todayEarnings
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white))
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //               data.data.schemetype != 1
                      //                   ? Card(
                      //                       elevation: 5,
                      //                       shape: RoundedRectangleBorder(
                      //                         //side: BorderSide(color: Colors.white70, width: 1),
                      //                         borderRadius: BorderRadius.circular(10),
                      //                       ),

                      //                       child: Container(

                      //                     decoration: new BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(10),

                      //     gradient: LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       stops: [
                      //         0.1,
                      //         0.9,
                      //         // 0.6,
                      //         // 0.9,
                      //       ],
                      //       colors: [
                      //    HexColor("#BB4A97"),
                      //  HexColor("#7149A4")
                      //         // Colors.indigo,
                      //         // Colors.teal,
                      //       ],
                      //     ),

                      //       image: new DecorationImage(
                      //         fit: BoxFit.cover,
                      //         colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      //         image:  AssetImage (
                      //           'assets/ftbg.png',
                      //         ),
                      //       ),
                      //     ),

                      //                         child: Padding(
                      //                           padding: const EdgeInsets.only(
                      //                               left: 15.0, right: 15, top: 10, bottom: 10),
                      //                           child: Column(
                      //                             crossAxisAlignment: CrossAxisAlignment.start,
                      //                             children: [
                      //                               Padding(
                      //                                 padding: const EdgeInsets.only(
                      //                                     top: 5.0, bottom: 15),
                      //                                 child: Text(
                      //                                   data.data.schemeName,
                      //                                   style: TextStyle(
                      //                                       fontWeight: FontWeight.w600,
                      //                                       color: HexColor("#643036")),
                      //                                 ),
                      //                               ),
                      //                               Row(
                      //                                 children: [
                      //                                   Expanded(
                      //                                     child: Container(
                      //                                       decoration: BoxDecoration(
                      //                                         borderRadius: BorderRadius.all(
                      //                                             Radius.circular(100)),
                      //                                         border: Border.all(
                      //                                           color: HexColor(
                      //                                               "#643036"), //                   <--- border color
                      //                                           width: 1.4,
                      //                                         ),
                      //                                       ),
                      //                                       child: StepProgressIndicator(
                      //                                         totalSteps: totalpayment,
                      //                                         currentStep: totalpayed,
                      //                                         size: 11,
                      //                                         padding: 0,
                      //                                         selectedColor:
                      //                                             HexColor("#643036"),
                      //                                         unselectedColor:
                      //                                             Colors.transparent,
                      //                                         roundedEdges: Radius.circular(20),
                      //                                         selectedGradientColor:
                      //                                             LinearGradient(
                      //                                           begin: Alignment.topLeft,
                      //                                           end: Alignment.bottomRight,
                      //                                           colors: [
                      //                                             HexColor("#643036"),
                      //                                             HexColor("#643036")
                      //                                           ],
                      //                                         ),
                      //                                         unselectedGradientColor:
                      //                                             LinearGradient(
                      //                                           begin: Alignment.topLeft,
                      //                                           end: Alignment.bottomRight,
                      //                                           colors: [
                      //                                             Colors.transparent,
                      //                                             Colors.transparent
                      //                                           ],
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(
                      //                                     width: 10,
                      //                                   ),
                      //                                   Text(
                      //                                     totalpayed.toString() +
                      //                                         "/" +
                      //                                         totalpayment.toString(),
                      //                                     style: TextStyle(
                      //                                         fontSize: 12,
                      //                                         color: HexColor("#643036")),
                      //                                   )
                      //                                 ],
                      //                               ),
                      //                               Padding(
                      //                                 padding: const EdgeInsets.only(
                      //                                     top: 20.0, bottom: 10),
                      //                                 child: Row(
                      //                                   children: [
                      //                                     Column(
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment.start,
                      //                                       children: [
                      //                                         Text("Today's Rate",
                      //                                             style: TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight.w400,
                      //                                                 fontSize: 11,
                      //                                                 color:
                      //                                                     HexColor("#643036"))),
                      //                                         Text(
                      //                                             "₹ " +
                      //                                                 data.data.todayRate
                      //                                                     .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight.w600,
                      //                                                 fontSize: 18,
                      //                                                 color:
                      //                                                     HexColor("#643036")))
                      //                                       ],
                      //                                     ),
                      //                                     Spacer(),
                      //                                     data.data.paymentType == 0
                      //                                         ? Column(
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment.end,
                      //                                             children: [
                      //                                               Text("Today's Earnings",
                      //                                                   style: TextStyle(
                      //                                                       fontWeight:
                      //                                                           FontWeight.w400,
                      //                                                       fontSize: 11,
                      //                                                       color: HexColor(
                      //                                                           "#643036"))),
                      //                                               Text(
                      //                                                   "₹ " +
                      //                                                       data.data
                      //                                                           .todayEarnings
                      //                                                           .toString(),
                      //                                                   style: TextStyle(
                      //                                                       fontWeight:
                      //                                                           FontWeight.w600,
                      //                                                       fontSize: 18,
                      //                                                       color: HexColor(
                      //                                                           "#643036")))
                      //                                             ],
                      //                                           )
                      //                                         : Container()
                      //                                   ],
                      //                                 ),
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     )
                      //                   : Card(
                      //                       elevation: 5,
                      //                       shape: RoundedRectangleBorder(
                      //                         //side: BorderSide(color: Colors.white70, width: 1),
                      //                         borderRadius: BorderRadius.circular(10),
                      //                       ),
                      //                       color: HexColor("#FFD98D"),
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 15.0, right: 15, top: 10, bottom: 10),
                      //                         child: Column(
                      //                           crossAxisAlignment: CrossAxisAlignment.center,
                      //                           children: [
                      //                             Padding(
                      //                               padding: const EdgeInsets.only(
                      //                                   top: 5.0, bottom: 15),
                      //                               child: Text(
                      //                                 data.data.schemeName,
                      //                                 style: TextStyle(
                      //                                     fontWeight: FontWeight.w600,
                      //                                     color: HexColor("#643036"),
                      //                                     fontSize: 18),
                      //                               ),
                      //                             ),
                      //                             Container(
                      //                                 child: Column(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.center,
                      //                               children: [
                      //                                 Text(
                      //                                   "First half of scheme period till " +
                      //                                       data.data.subs.dateCheck
                      //                                           .toString()
                      //                                           .substring(0, 10),
                      //                                   style: TextStyle(fontSize: 13),
                      //                                 ),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Divider(
                      //                                     thickness: 1.0,
                      //                                     color: HexColor("#643036")),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Row(
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment.center,
                      //                                   children: [
                      //                                     Text("Payment made on first half ",
                      //                                         style: TextStyle(fontSize: 13)),
                      //                                     Text(
                      //                                         "₹" +
                      //                                             data.data.halfPaymentSum
                      //                                                 .toString(),
                      //                                         style: TextStyle(
                      //                                             fontSize: 14,
                      //                                             fontWeight:
                      //                                                 FontWeight.bold)),
                      //                                   ],
                      //                                 ),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Divider(
                      //                                     thickness: 1.0,
                      //                                     color: HexColor("#643036")),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Row(
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment.center,
                      //                                   children: [
                      //                                     Text("Average payment made ",
                      //                                         style: TextStyle(fontSize: 13)),
                      //                                     Text(
                      //                                         "₹" +
                      //                                             data.data.average
                      //                                                 .toString(),
                      //                                         style: TextStyle(
                      //                                             fontSize: 14,
                      //                                             fontWeight:
                      //                                                 FontWeight.bold))
                      //                                   ],
                      //                                 ),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Divider(
                      //                                     thickness: 1.0,
                      //                                     color: HexColor("#643036")),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Text(
                      //                                     "Scheme end on " +
                      //                                         data.data.lastDate
                      //                                             .elementAt(0)
                      //                                             .paymentEndDates
                      //                                             .toString()
                      //                                             .substring(0, 10),
                      //                                     style: TextStyle(fontSize: 13)),
                      //                                 SizedBox(
                      //                                   height: 10,
                      //                                 ),
                      //                                 Divider(
                      //                                     thickness: 1.0,
                      //                                     color: HexColor("#643036")),
                      //                               ],
                      //                             )),
                      //                             Center(
                      //                               child: Padding(
                      //                                 padding: const EdgeInsets.only(
                      //                                     top: 10.0, bottom: 10),
                      //                                 child: Row(
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment.center,
                      //                                   children: [
                      //                                     Spacer(),
                      //                                     Column(
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment.center,
                      //                                       children: [
                      //                                         Text("Today's Rate",
                      //                                             style: TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight.w400,
                      //                                                 fontSize: 11,
                      //                                                 color: HexColor(
                      //                                                     "#643036"))),
                      //                                         Text(
                      //                                             "₹ " +
                      //                                                 data.data.todayRate
                      //                                                     .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight.w600,
                      //                                                 fontSize: 18,
                      //                                                 color: HexColor(
                      //                                                     "#643036")))
                      //                                       ],
                      //                                     ),
                      //                                     Spacer(),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      SizedBox(
                        height: 10,
                      ),
                      // Card(
                      //     elevation: 5,
                      //     shape: RoundedRectangleBorder(
                      //       //side: BorderSide(color: Colors.white70, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     color: HexColor("#FECBBB"),
                      //     child: Padding(
                      //         padding: const EdgeInsets.only(
                      //             left: 15.0, right: 15, top: 10, bottom: 10),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(top: 5.0),
                      //                   child: Text(
                      //                     "Wallet",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.w600,
                      //                         color: HexColor("#643036"),
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(bottom: 5),
                      //                   child: Text(
                      //                     "Balance",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.w500,
                      //                         color: HexColor("#643036")),
                      //                   ),
                      //                 ),
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(bottom: 15),
                      //                   child: Text(
                      //                       "₹ " +
                      //                           data.data.sumAmount.toString(),
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 18,
                      //                           color: HexColor("#643036"))),
                      //                 ),
                      //               ],
                      //             ),
                      //             Spacer(),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.end,
                      //               children: [
                      //                 IconButton(
                      //                     // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      //                     icon: FaIcon(
                      //                       FontAwesomeIcons.wallet,
                      //                       color: HexColor("#707070"),
                      //                     ),
                      //                     onPressed: () {
                      //                       print("Pressed");
                      //                     }),

                      //                 //   Padding(
                      //                 //   padding: const EdgeInsets.only(bottom: 5),
                      //                 //   child: Text("Balance",style: TextStyle(fontWeight: FontWeight.w500,color: HexColor("#643036")),),
                      //                 // ),

                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.only(
                      //                           bottom: 15, right: 15),
                      //                       child: Container(
                      //                           child: Image.asset(
                      //                         "assets/goldcoin.png",
                      //                         fit: BoxFit.fill,
                      //                       )),
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.only(
                      //                           bottom: 15),
                      //                       child: Text(
                      //                           "₹ " +
                      //                               data.data.sumGram
                      //                                   .toString(),
                      //                           style: TextStyle(
                      //                               fontWeight: FontWeight.w600,
                      //                               fontSize: 18,
                      //                               color:
                      //                                   HexColor("#643036"))),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ))),
                      vis
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20.0, top: 10, bottom: 5),
                              child: Text("PENDING PAYMENT",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: HexColor("#2D2D2D"),
                                  )),
                            )
                          : Container(),
                      data.data.schemetype == 1
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#F8D7DA"),
                                    border: Border.all(
                                      width: 1.5,
                                      color: HexColor("#F5C6CB"),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Container(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0),
                                                    child: Text(
                                                      "Rs. " +
                                                          data.data.monthlyAmont
                                                              .toString()
                                                              .split(".")[0],
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#721C24"),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )),
                                                ),
                                                Center(
                                                    child: Text(" to ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: HexColor(
                                                                "#721C24"),
                                                            fontSize: 15))),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Container(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0),
                                                    child: Text(
                                                      data.data.amountTo
                                                          .toString()
                                                          .split(".")[0],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              "#721C24"),
                                                          fontSize: 15),
                                                    ),
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Date : " +
                                                    new DateTime.now()
                                                        .toString()
                                                        .substring(0, 10),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: HexColor("#721C24")),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Visibility(
                                        visible: ios,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: () async {
                                              if (await getSavedObject(
                                                          "roleid") ==
                                                      2 ||
                                                  await getSavedObject(
                                                          "roleid") ==
                                                      4) {
                                                Map details = {
                                                  'type': data.data.paymentType,
                                                  'UserId':
                                                      await getSavedObject(
                                                          'userid'),
                                                  'toamount':
                                                      data.data.amountTo,
                                                  'SheduledDateId':
                                                      paymentpendingid,
                                                  'gram': data
                                                      .data.todayEarnings
                                                      .toString(),
                                                  'amount':
                                                      data.data.monthlyAmont,
                                                  'taransactionId': "nill",
                                                  'subscriptionId':
                                                      await getSavedObject(
                                                          'subscription'),
                                                  'paidBy':
                                                      await getSavedObject(
                                                          'userid'),
                                                  'todaysrate':
                                                      data.data.todayRate,
                                                  'schemetype': data
                                                      .data.schemetype
                                                      .toString(),
                                                  'average': data.data.average
                                                      .toString(),
                                                  'currentstatus':
                                                      data.data.half.toString()
                                                };

                                                if (upistatus.compareTo("0") ==
                                                    0) {
                                                  Navigator.pushNamed(
                                                          context,
                                                          Paymentscreen
                                                              .routeName,
                                                          arguments: details)
                                                      .then((value) {
                                                    getProfile();
                                                  });
                                                } else {
                                                  showToast(
                                                      "You have already made a payment waiting for approval");
                                                }
                                              } else if (await getSavedObject(
                                                      "roleid") ==
                                                  3) {
                                                //  if(sendConfirmation())
                                                data.data.paymentType == 0
                                                    ? showAlertDialog(context)
                                                    : showAlertDialogvarient(
                                                        context);
                                              }
                                            },
                                            child: Visibility(
                                              visible: ios,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#F5C6CB"),
                                                    // Set border width
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            100.0)), // Set rounded corner radius
                                                    // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 18,
                                                            right: 18,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Text(
                                                      "PAY",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            HexColor("#720755"),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : vis
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Card(
                                    color: HexColor("#F8D7DA"),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              data.data.paymentType == 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Container(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0,
                                                                right: 0,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Text(
                                                          "Rs. " +
                                                              data.data
                                                                  .monthlyAmont,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  "#EE4E4E"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      )),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 0),
                                                            child: Container(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      right: 0,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Text(
                                                                "Rs. " +
                                                                    data.data
                                                                        .monthlyAmont,
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        "#721C24"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            )),
                                                          ),
                                                          Center(
                                                              child: Text(
                                                                  " to ",
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          "#721C24"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15))),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 0),
                                                            child: Container(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 6,
                                                                      right: 6,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Text(
                                                                data.data
                                                                    .amountTo,
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        "#721C24"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            )),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                              data.data.schemetype != 1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Due date : " +
                                                                DateFormat(
                                                                        "dd-MM-yyyy")
                                                                    .format(
                                                                        paymentStartDates),
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#721C24"),
                                                                fontSize: 13),
                                                          ),
                                                          Text(
                                                              " to " +
                                                                  DateFormat(
                                                                          "dd-MM-yyyy")
                                                                      .format(
                                                                          paymentEndDates),
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#721C24"),
                                                                  fontSize:
                                                                      13)),
                                                        ],
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          left: .0,
                                                          right: 15,
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Container(
                                                        child: Text(
                                                            "Date  : " +
                                                                new DateTime
                                                                        .now()
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10),
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#721C24"),
                                                                fontSize: 13)),
                                                      ),
                                                    ),

                                              // data.data.schemetype != 1
                                              //     ? Padding(
                                              //         padding: const EdgeInsets.only(
                                              //             top: 10, bottom: 10),
                                              //         child: Column(
                                              //           crossAxisAlignment:
                                              //               CrossAxisAlignment.start,
                                              //           children: [
                                              //             Text("Start Date : " +
                                              //                 DateFormat("dd-MM-yyyy")
                                              //                     .format(
                                              //                         paymentStartDates)),
                                              //             Text("End Date   : " +
                                              //                 DateFormat("dd-MM-yyyy")
                                              //                     .format(
                                              //                         paymentEndDates)),
                                              //           ],
                                              //         ),
                                              //       )
                                              //     : Padding(
                                              //         padding: EdgeInsets.only(
                                              //             left: .0,
                                              //             right: 15,
                                              //             top: 10,
                                              //             bottom: 10),
                                              //         child: Container(
                                              //           child: Text("Date  : " +
                                              //               new DateTime.now()
                                              //                   .toString()
                                              //                   .substring(0, 10)),
                                              //         ),
                                              //       ),

                                              // data.data.paymentType == 0
                                              //     ? Padding(
                                              //         padding: const EdgeInsets.only(
                                              //             bottom: 10),
                                              //         child: Container(
                                              //             decoration: BoxDecoration(
                                              //                 color:
                                              //                     HexColor("#FFCD5E"),
                                              //                 //                   border: Border.all(
                                              //                 //   color: Colors.red[500],
                                              //                 // ),
                                              //                 borderRadius:
                                              //                     BorderRadius.all(
                                              //                         Radius.circular(
                                              //                             20))),
                                              //             child: Padding(
                                              //               padding:
                                              //                   const EdgeInsets.only(
                                              //                       left: 6,
                                              //                       right: 6,
                                              //                       top: 2,
                                              //                       bottom: 2),
                                              //               child: Text("₹ " +
                                              //                   data.data
                                              //                       .monthlyAmont),
                                              //             )),
                                              //       )
                                              //     : Padding(
                                              //         padding: const EdgeInsets.only(
                                              //             bottom: 10),
                                              //         child: Row(
                                              //           children: [
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets.only(
                                              //                       bottom: 0),
                                              //               child: Container(
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                           color: HexColor(
                                              //                               "#FFCD5E"),
                                              //                           //                   border: Border.all(
                                              //                           //   color: Colors.red[500],
                                              //                           // ),
                                              //                           borderRadius:
                                              //                               BorderRadius.all(
                                              //                                   Radius.circular(
                                              //                                       20))),
                                              //                   child: Padding(
                                              //                     padding:
                                              //                         const EdgeInsets
                                              //                                 .only(
                                              //                             left: 6,
                                              //                             right: 6,
                                              //                             top: 2,
                                              //                             bottom: 2),
                                              //                     child: Text("₹ " +
                                              //                         data.data
                                              //                             .monthlyAmont),
                                              //                   )),
                                              //             ),
                                              //             Center(child: Text(" To ")),
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets.only(
                                              //                       bottom: 0),
                                              //               child: Container(
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                           color: HexColor(
                                              //                               "#FFCD5E"),
                                              //                           //                   border: Border.all(
                                              //                           //   color: Colors.red[500],
                                              //                           // ),
                                              //                           borderRadius:
                                              //                               BorderRadius.all(
                                              //                                   Radius.circular(
                                              //                                       20))),
                                              //                   child: Padding(
                                              //                     padding:
                                              //                         const EdgeInsets
                                              //                                 .only(
                                              //                             left: 6,
                                              //                             right: 6,
                                              //                             top: 2,
                                              //                             bottom: 2),
                                              //                     child: Text("₹ " +
                                              //                         data.data
                                              //                             .amountTo),
                                              //                   )),
                                              //             )
                                              //           ],
                                              //         ),
                                              //       )
                                            ],
                                          ),
                                          Spacer(),

//// for ios

                                          Visibility(
                                            visible: ios,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  if (await getSavedObject(
                                                              "roleid") ==
                                                          2 ||
                                                      await getSavedObject(
                                                              "roleid") ==
                                                          4) {
                                                    Map details = {
                                                      'type':
                                                          data.data.paymentType,
                                                      'UserId':
                                                          await getSavedObject(
                                                              'userid'),
                                                      'toamount':
                                                          data.data.amountTo,
                                                      'SheduledDateId':
                                                          paymentpendingid,
                                                      'gram': data
                                                          .data.todayEarnings
                                                          .toString(),
                                                      'amount': data
                                                          .data.monthlyAmont,
                                                      'taransactionId': "nill",
                                                      'subscriptionId':
                                                          await getSavedObject(
                                                              'subscription'),
                                                      'paidBy':
                                                          await getSavedObject(
                                                              'userid'),
                                                      'todaysrate':
                                                          data.data.todayRate,
                                                      'schemetype': data
                                                          .data.schemetype
                                                          .toString(),
                                                      'average': data
                                                          .data.average
                                                          .toString(),
                                                      'currentstatus': data
                                                          .data.half
                                                          .toString()
                                                    };

                                                    if (upistatus
                                                            .compareTo("0") ==
                                                        0) {
                                                      Navigator.pushNamed(
                                                              context,
                                                              Paymentscreen
                                                                  .routeName,
                                                              arguments:
                                                                  details)
                                                          .then((value) {
                                                        getProfile();
                                                      });
                                                    } else {
                                                      showToast(
                                                          "You have already made a payment waiting for approval");
                                                    }
                                                  } else if (await getSavedObject(
                                                          "roleid") ==
                                                      3) {
                                                    //  if(sendConfirmation())
                                                    data.data.paymentType == 0
                                                        ? showAlertDialog(
                                                            context)
                                                        : showAlertDialogvarient(
                                                            context);
                                                  }
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#F5C6CB"),
                                                      // Set border width
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              100.0)), // Set rounded corner radius
                                                      // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              right: 25,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Text(
                                                        "PAY",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              "#720755"),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20.0, top: 20, bottom: 5),
                        child: Text(
                          "UPCOMING PAYMENT",
                          style: TextStyle(
                              color: HexColor("#2D2D2D"), fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.data.upcomingPayment.length > 2
                                ? 2
                                : data.data.upcomingPayment.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return data.data.schemetype == 1
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          color: HexColor("#FFF3CD"),
                                          border: Border.all(
                                            width: 1.5,
                                            color: HexColor("#FFF3CD"),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            bottom: 15,
                                            top: 15),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                        child: Container(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0,
                                                                  top: 0,
                                                                  bottom: 0),
                                                          child: Text(
                                                            "Rs." +
                                                                data.data
                                                                    .monthlyAmont
                                                                    .toString()
                                                                    .split(
                                                                        ".")[0],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: HexColor(
                                                                    "#856404"),
                                                                fontSize: 15),
                                                          ),
                                                        )),
                                                      ),
                                                      Center(
                                                          child: Text(" to ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: HexColor(
                                                                      "#856404"),
                                                                  fontSize:
                                                                      15))),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                        child: Container(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0,
                                                                  top: 0,
                                                                  bottom: 0),
                                                          child: Text(
                                                            data.data.amountTo
                                                                .toString()
                                                                .split(".")[0],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: HexColor(
                                                                    "#856404"),
                                                                fontSize: 15),
                                                          ),
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Due Date  : " +
                                                          DateFormat(
                                                                  "dd-MM-yyyy")
                                                              .format(DateTime
                                                                  .now())
                                                              .toString()
                                                              .substring(0, 10),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: HexColor(
                                                              "#856404")),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          color: HexColor("#FFF3CD"),
                                          border: Border.all(
                                            width: 1.5,
                                            color: HexColor("#FFF3CD"),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0,
                                            right: 25,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            data.data.paymentType == 0
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .only(bottom: 0),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(

                                                                //                   border: Border.all(
                                                                //   color: Colors.red[500],
                                                                // ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0),
                                                            child: Text(
                                                              "₹" +
                                                                  data.data
                                                                      .monthlyAmont,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: HexColor(
                                                                      "#856404"),
                                                                  fontSize: 18),
                                                            ))))
                                                : Row(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 0),
                                                          child: Container(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        right:
                                                                            0,
                                                                        top: 0,
                                                                        bottom:
                                                                            0),
                                                                child: Text(
                                                                  "Rs. " +
                                                                      data.data
                                                                          .monthlyAmont,
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          "#856404"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                )),
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 0,
                                                                  top: 0),
                                                          child: Container(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 0,
                                                                        bottom:
                                                                            0),
                                                                child: Text(
                                                                  "to " +
                                                                      data.data
                                                                          .amountTo
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                        "#856404",
                                                                      ),
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15),
                                                                )),
                                                          )),
                                                    ],
                                                  ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: data.data.schemetype != 1
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Due date : " +
                                                              DateFormat(
                                                                      "dd-MM-yyyy")
                                                                  .format(data
                                                                      .data
                                                                      .upcomingPayment
                                                                      .elementAt(
                                                                          index)
                                                                      .paymentStartDates),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: HexColor(
                                                                  "#856404")),
                                                        ),
                                                        Text(
                                                          " to " +
                                                              DateFormat(
                                                                      "dd-MM-yyyy")
                                                                  .format(data
                                                                      .data
                                                                      .upcomingPayment
                                                                      .elementAt(
                                                                          index)
                                                                      .paymentEndDates),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: HexColor(
                                                                  "#856404")),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(
                                                      child: Text(
                                                          "Start Date : " +
                                                              new DateTime.now()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)),
                                                    )
                                              // Column(children: [
                                              //         Text("Start Date : " +
                                              //  new DateTime.now().toString()
                                              //                 ),
                                              // ],)
                                              ,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                      )
                    ]),
              )),
            )
          : Container(),
    );
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

    print(details);
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Sheduledmodel datas = await Sheduledservice.postService(details);
      print("Reached here");

      PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        buildNumber = packageInfo.buildNumber;
        print(buildNumber);

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
        data = datas;
        print(data);
        //  test();
      });
      totalpayment = data.data.sheduledList.length;
      data.data.schemetype != 1
          ? datas.data.sheduledList.forEach((element) {
              if (element.status == 2) {
                totalpayed++;
              } else if (element.status == 1) {
                setState(() {
                  paymentpendingid = element.id;
                  schemeId = element.schemeId;
                  schemeAmountId = element.schemeAmountId;
                  paymentStartDates = element.paymentStartDates;
                  paymentEndDates = element.paymentEndDates;
                  upistatus = element.upiStatus.toString();
                  vis = true;
                });
              }
            })
          : setState(() {
              paymentpendingid = data.data.upcomingPayment.elementAt(0).id;
              schemeId = data.data.upcomingPayment.elementAt(0).schemeId;
              schemeAmountId =
                  data.data.upcomingPayment.elementAt(0).schemeAmountId;
              upistatus =
                  data.data.upcomingPayment.elementAt(0).upiStatus.toString();
              // paymentStartDates = new DateTime.now();
              // paymentEndDates = new DateTime.now();
              vis = true;
            });

      setState(() {
        totalpayed;
        totalpayment;
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();

      print(e);
      //  Navigator.pop(context);
    }
  }

  void agentpay(String amount, String gram) async {
    Map details = {
      'UserId': await getSavedObject('customerid'),
      'SheduledDateId': paymentpendingid,
      'gram': gram,
      'amount': amount,
      'taransactionId': "nil",
      'subscriptionId': await getSavedObject('subscription'),
      'paidBy': await getSavedObject('userid')
    };
    print("__________________________________");
    print(details);
    print("__________________________________");
    try {
      EasyLoading.show(status: 'Loading...');
      Paymentmodel datas = await Paymentservice.postPay(details);
      print("Reached here");
      EasyLoading.dismiss();
      getProfile();
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        agentpay(data.data.monthlyAmont, data.data.todayEarnings.toString());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment"),
      content: Text("Would you like to continue with the paymnet?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogvarient(BuildContext context) {
    double gram = 0;
    String finalgram = "";
    // amountController.addListener(() {
    //   if (amountController.text.toString().isNotEmpty)
    //     setState(() {
    //       gram = double.parse(amountController.text.toString());
    //     });
    // });

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        amountController.text = "";
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed: () {
          try {
            if (data.data.schemetype == 1) {
              if ((double.parse(amountController.text.toString()) <=
                      double.parse(data.data.amountTo.toString())) &&
                  (double.parse(amountController.text.toString()) >=
                      double.parse(data.data.monthlyAmont.toString()))) {
                if (data.data.half.toString().compareTo("dialy") == 0) {
                  Navigator.pop(context);
                  agentpay(amountController.text.toString(), finalgram);
                }

                if (data.data.half.toString().compareTo("dialy") != 0) {
                  if (double.parse(amountController.text.toString()) <=
                      double.parse(data.data.average.toString())) {
                    Navigator.pop(context);
                    agentpay(amountController.text.toString(), finalgram);
                  } else {
                    showToast("Please enter amount below average");
                  }
                }

                // Navigator.pop(context);
                // agentpay(amountController.text.toString(), finalgram);
              } else {
                showToast("Please enter amount with in range");
              }
            } else {
              if ((double.parse(amountController.text.toString()) <=
                      double.parse(data.data.amountTo.toString())) &&
                  (double.parse(amountController.text.toString()) >=
                      double.parse(data.data.monthlyAmont.toString()))) {
                Navigator.pop(context);
                agentpay(amountController.text.toString(), finalgram);
              } else {
                showToast("Please enter amount with in range");
              }
            }
          } catch (e) {
            showToast("Please enter amount with in range");
          }
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment"),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please enter the amount to pay ?"),
              Center(
                child: Container(
                    width: 150,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter amount",
                        counterText: "",
                      ),
                      controller: amountController,
                      maxLength: 8,
                      onChanged: (value) {
                        setState(() {
                          print(value + "test");
                          if (value.isEmpty) {
                            gram = 0;
                            finalgram = "";
                          } else {
                            gram = double.parse(value) /
                                double.parse(data.data.todayRate.toString());

                            finalgram = gram.toStringAsFixed(3);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              //  Text("Gold in gram :" + finalgram),
            ],
          ),
        );
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getScheme() async {
    int userid;
    // subidlist.clear();
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      userid = await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject("userid");
      Subscriptionlistmodel datas =
          await Schemelistgetservice.getScheme(userid);
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();

      if (datas.data.subscriptionList.isEmpty) {
        if (role == 2 || role == 4) {
          Navigator.pushReplacementNamed(context, SelectScheme.routeName);
        }
      }
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
