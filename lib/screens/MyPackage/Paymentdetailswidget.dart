// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/newBottomDrawer.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/model/prePaymentModel.dart';
import 'package:aradhana/model/profileeditmodel.dart';
import 'package:aradhana/screens/MyPackage/ViewPaidList.dart';
import 'package:aradhana/screens/MyPackage/ViewPendingList.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/screens/Paymentsendscreen/Paymentscreen.dart';
import 'package:aradhana/screens/Recepit/Recepit.dart';
import 'package:aradhana/service/prePaymentService.dart';
import 'package:aradhana/service/profileeditservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Util/Utils.dart';
import '../../model/SaveSchemeModel.dart';
import '../../model/paymentmodel.dart';
import '../../service/Paymentservice.dart';
import '../../service/Sheduledservice.dart';
import '../../service/schemeName.dart';

class Paymentdetailswidget extends StatefulWidget {
  final dynamic paymentdate;

  final Function paymentrefresh;
  const Paymentdetailswidget({
    Key key,
    this.paymentdate,
    this.paymentrefresh,
  }) : super(key: key);

  @override
  State<Paymentdetailswidget> createState() => _PaymentdetailswidgetState();
}

class _PaymentdetailswidgetState extends State<Paymentdetailswidget> {
  Profileditmodel myData = new Profileditmodel();
  bool payPress = false;
  double gram = 0;
  String finalgram = "";
  bool sentTap = false;
  PrePaymentModel preNewData;
  var myPhone;
  var myEmail;
  var moneyy;
  final amountController = TextEditingController();
  final alertAmount = TextEditingController();
  bool ios = true;
  getdata() async {
    Profileditmodel profileData = await Schemelistgetprofile.getprofile();
    setState(() {
      myData = profileData;
      myPhone = myData.data.userId.phone;
      myEmail = myData.data.userId.email;
    });
    int z = await getSavedObject('userid');
    bool b = z == iosUser ? false : true;
    print(b);
    setState(() {
      ios = b;
      print(ios);
    });
  }

  int role;

  getrole() async {
    role = await getSavedObject("roleid");
    print(role);
    //number= await getSavedObject("phone");
  }

  int totalpayed;
  bool vis;
  Sheduledmodel data;
  dynamic paymentpendingid;
  dynamic schemeId;
  dynamic schemeAmountId;
  dynamic paymentStartDates;
  dynamic paymentEndDates;
  var termsCondition;

  String upistatus;
  void getProfile() async {
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

      Sheduledmodel datas = await Sheduledservice.postService(details);
      print("Reached here");

      setState(() {
        data = datas;
        termsCondition = datas.data.termsandcondtion.description;
      });
//,,m
      if (datas.data.subs.userSchemeName != null)
        userSchemename = datas.data.subs.userSchemeName.toString();

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
                  totalpayed;
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
      String str = data.data.todayRate;
      var arr = str.split('.');
      moneyy = arr[0];
      EasyLoading.dismiss();
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();

      print(e);
      //  Navigator.pop(context);
    }
  }

  String userSchemename;

  TextEditingController _nameController = TextEditingController();

  Future<SaveSchemeModel> saveName() async {
    userSchemename = _nameController.text.toString();
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription'),
      'user_scheme_name': userSchemename
    };
    print(details);
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      SaveSchemeModel datas = await SaveSchemeName.postService(details);

      if (datas.success) {
        setState(() {
          userSchemename = _nameController.text.toString();
        });

        _nameController.text = "";
        Navigator.pop(context);
      }

      EasyLoading.dismiss();

      return datas;
    } catch (e) {
      // showErrorMessage(e);

      EasyLoading.dismiss();
      Navigator.pop(context);
      print(e);
      //  Navigator.pop(context);

    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getProfile();
    getrole();
  }

  void verifyPayment(String orderId) {
    print("Verify Payment");
  }

  // void onError(CFErrorResponse errorResponse, String orderId) {
  //   print("Error while making payment");
  // }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container()
        : Scaffold(
            appBar: AppBar(
              leading: role == 2 || role == 4
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: IconButton(
                            icon: const Icon(Icons.sort, size: 30),
                            onPressed: () {
                              newDrawerr(context, termsCondition);
                              // Scaffold.of(context).openDrawer();
                            }),
                      ),
                    )
                  : Container(
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
              centerTitle: true,
              title: Image.asset("assets/logoOnly.png", height: 40),
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
                                    child: const Icon(Icons.notifications,
                                        size: 30),
                                  ),
                                  data.data.notificationCount == 0
                                      ? Container()
                                      : Container(
                                          width: 30,
                                          height: 30,
                                          alignment: Alignment.topRight,
                                          margin: const EdgeInsets.only(top: 0),
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xffc32c37),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Center(
                                                child: Text(
                                                  data.data.notificationCount
                                                      .toString(),
                                                  style: const TextStyle(
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
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        //side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: data.data.schemetype != 1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: goldenGradientLeftRight,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.black54,
                                          BlendMode.darken,
                                        ),
                                        image: AssetImage(
                                            'assets/fixedAssets/bg0.png'),
                                      ),
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          userSchemename != null
                                              ? Expanded(
                                                  child: Text(
                                                    "Scheme Name : $userSchemename",
                                                    style: font(
                                                        14,
                                                        data.data.schemetype ==
                                                                1
                                                            ? Colors.white
                                                            : Colors.black,
                                                        FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        child: data.data.schemetype != 1
                                            ? Text(
                                                data.data.schemeName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              )
                                            : Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10,
                                                          bottom: 10,
                                                          top: 10),
                                                  child: Text(
                                                    data.data.schemeName,
                                                    style: data.data
                                                                .schemetype !=
                                                            1
                                                        ? font(16, Colors.black,
                                                            FontWeight.w600)
                                                        : font(16, Colors.white,
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    data.data.schemetype != 1
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    border: Border.all(
                                                        color: Colors
                                                            .black54, //                   <--- border color
                                                        width: 1.4),
                                                  ),
                                                  child: StepProgressIndicator(
                                                    totalSteps: data.data
                                                        .sheduledList.length,
                                                    currentStep: totalpayed,
                                                    size: 11,
                                                    padding: 0,
                                                    selectedColor:
                                                        HexColor("#f7D177"),
                                                    unselectedColor:
                                                        Colors.transparent,
                                                    roundedEdges:
                                                        const Radius.circular(
                                                            20),
                                                    selectedGradientColor:
                                                        const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Colors.black,
                                                        Colors.black
                                                      ],
                                                    ),
                                                    unselectedGradientColor:
                                                        const LinearGradient(
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
                                              Text(
                                                  "$totalpayed/${data.data.sheduledList.length}",
                                                  style:
                                                      data.data.schemetype != 1
                                                          ? size12_600
                                                          : size12_400)
                                            ],
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Column(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text("TOTAL AMOUNT",
                                                              style: font(
                                                                  15,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .w500)),
                                                          Text(
                                                              data.data.sumAmount !=
                                                                      null
                                                                  ? rs +
                                                                      data.data
                                                                              .sumAmount
                                                                              .toString()
                                                                              .split(".")[
                                                                          0]
                                                                  : "₹0",
                                                              style: font(
                                                                  16,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .bold))
                                                        ],
                                                      ),
                                                    ),
                                                    // Opacity(
                                                    //   opacity: 0,
                                                    //   child: Text(
                                                    //       totalpayed
                                                    //               .toString() +
                                                    //           "/" +
                                                    //           data
                                                    //               .data
                                                    //               .sheduledList
                                                    //               .length
                                                    //               .toString(),
                                                    //       style: data.data
                                                    //                   .schemetype !=
                                                    //               1
                                                    //           ? size14_700
                                                    //           : size14_700W),
                                                    // )
                                                  ],
                                                ),
                                                const SizedBox(
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
                                                            const SizedBox(
                                                                width: double
                                                                    .infinity),
                                                            Text(
                                                                "Last amount paid on ${DateFormat("dd-MMM-yyyy").format(data.data.lastPaymentAndDate.paymentDate)}",
                                                                style:
                                                                    size12_400W),
                                                            Text(
                                                                rs +
                                                                    data
                                                                        .data
                                                                        .lastPaymentAndDate
                                                                        .amount
                                                                        .toString()
                                                                        .split(
                                                                            ".")[0],
                                                                style: size14_400W),
                                                          ],
                                                        )),

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
                                                    Text("Today's Rate",
                                                        style: font(
                                                            12,
                                                            Colors.black,
                                                            FontWeight.w500)),
                                                    Text(rs + moneyy,
                                                        style: size20_700),
                                                  ],
                                                ),
                                                const Spacer(),
                                                data.data.paymentType == 0
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                              "Today's Earnings",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black)),
                                                          Text(
                                                              // rs +
                                                              data.data
                                                                  .todayEarnings
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black)),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
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
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                nameEdit();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [shadow],
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(10)),
                                      color: HexColor("#F5E9BB")),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8,
                                        left: 12,
                                        right: 12,
                                        bottom: 10),
                                    child: Icon(FontAwesomeIcons.userEdit,
                                        size: 15),
                                  )),
                            ),
                          ),
                          data.data.schemetype == 0
                              ? Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Image.asset(
                                      "assets/fixedAssets/monthlySchemeCoin.png",
                                      height: 96),
                                )
                              : const Opacity(opacity: 0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  div,
                  //////////////////////////////////////////////////////////

                  data.data.lastPaymentStatus != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              const Text("LAST PAYMENT STATUS",
                                  style: smallHeading),
                            ],
                          ),
                        )
                      : const Opacity(opacity: 0),
                  data.data.lastPaymentStatus != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                            // height: 70,
                            decoration: BoxDecoration(
                                color: data.data.lastPaymentStatus
                                            .lastpaymentStatus ==
                                        1
                                    ? Colors.white
                                    : data.data.lastPaymentStatus
                                                .lastpaymentStatus ==
                                            2
                                        ? const Color(0xffDEFFDD)
                                        : const Color(0xffFFCDD0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 20, bottom: 20),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Container(
                                          child: Text(
                                        "Date : ${DateFormat("dd-MMM-yyyy").format(data.data.lastPaymentStatus.updatedAt)}",
                                        style: size14_400,
                                      )),
                                    ),
                                    if (data.data.lastPaymentStatus
                                            .lastpaymentStatus ==
                                        1)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Container(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(CupertinoIcons.clock,
                                                  size: 14),
                                              w(5),
                                              Text(
                                                "Waiting for \napproval",
                                                textAlign: TextAlign.center,
                                                style: font(10, Colors.brown,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ),
                                    if (data.data.lastPaymentStatus
                                            .lastpaymentStatus ==
                                        2)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Container(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.check,
                                                  color: Colors.green,
                                                  size: 18),
                                              w(5),
                                              Text(
                                                "PAID",
                                                style: font(12, Colors.green,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ),
                                    if (data.data.lastPaymentStatus
                                            .lastpaymentStatus ==
                                        3)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.close,
                                                  size: 18, color: Colors.red),
                                              w(3),
                                              Text(
                                                "Rejected",
                                                style: font(12, Colors.red,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  h(20),
///////////////////////////// schemeType 1 = marriage //////////////////////////////////
                  data.data.schemetype == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, top: 15, bottom: 10),
                              child:
                                  Text("PENDING PAYMENT", style: smallHeading),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black12),
                                    boxShadow: [shadow],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Container(
                                                    child: Text(
                                                  "$rs${data.data.monthlyAmont.toString().split(".")[0]}   to  ",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Container(
                                                    child: Text(
                                                  rs +
                                                      data.data.amountTo
                                                          .toString()
                                                          .split(".")[0],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontSize: 15),
                                                )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Date : ${DateFormat("dd MMM-yyyy").format(DateTime.now())}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: HexColor("#721C24")),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Visibility(
                                        visible: true,
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xff1E9014),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100.0)),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 28,
                                                            right: 28,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Text(
                                                      "PAY",
                                                      style: font(
                                                          14,
                                                          Colors.white,
                                                          FontWeight.w600),
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
                            ),
                          ],
                        )
                      : vis
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#F8D7DA"),
                                    border: Border.all(
                                        width: 1.5, color: HexColor("#F5C6CB")),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
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
                                                          bottom: 10),
                                                  child: Container(
                                                      child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                    child: Text(
                                                        rs +
                                                            data.data
                                                                .monthlyAmont
                                                                .toString()
                                                                .split(".")[0],
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#EE4E4E"),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17)),
                                                  )),
                                                )
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      rs +
                                                          data.data.monthlyAmont
                                                              .toString()
                                                              .split(".")[0],
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#721C24"),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    )),
                                                    Center(
                                                        child: Text(
                                                      " to ",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#721C24"),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Text(
                                                        data.data.amountTo
                                                            .toString()
                                                            .split(".")[0],
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#721C24"),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Date : ${DateFormat("dd-MMM-yyyy").format(
                                                    paymentStartDates,
                                                  )}",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Text(
                                                  "  to  ${DateFormat("dd-MMM-yyyy").format(paymentEndDates)}",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          if (await getSavedObject("roleid") ==
                                                  2 ||
                                              await getSavedObject("roleid") ==
                                                  4) {
                                            Map details = {
                                              'type': data.data.paymentType,
                                              'UserId': await getSavedObject(
                                                  'userid'),
                                              'toamount': data.data.amountTo,
                                              'SheduledDateId':
                                                  paymentpendingid,
                                              'gram': data.data.todayEarnings
                                                  .toString(),
                                              'amount': data.data.monthlyAmont,
                                              'taransactionId': "nill",
                                              'subscriptionId':
                                                  await getSavedObject(
                                                      'subscription'),
                                              'paidBy': await getSavedObject(
                                                  'userid'),
                                              'todaysrate': data.data.todayRate
                                            };
                                            if (upistatus.compareTo("0") == 0) {
                                              Navigator.pushNamed(context,
                                                      Paymentscreen.routeName,
                                                      arguments: details)
                                                  .then((value) {
                                                getProfile();
                                                setState(() {});
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

// for ios
                                        child: Visibility(
                                          visible: ios,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                // Set border width
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        100.0)), // Set rounded corner radius
                                                // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25,
                                                    right: 25,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Text(
                                                  "PAY",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                  h(20),

                  if (data.data.upcomingPayment.length != 0)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 10, top: 5),
                      child: Row(
                        children: [
                          const Text("UPCOMING PAYMENT", style: smallHeading),
                          const Spacer(),
                          data.data.schemetype != 1
                              ? InkWell(
                                  onTap: (() {
                                    Map details = {
                                      "list": data,
                                    };
                                    Navigator.pushNamed(
                                        context, UpcomingPaymentList.routeName,
                                        arguments: details);
                                  }),
                                  child: Text(
                                    "VIEW ALL",
                                    style: font(
                                        10, Colors.black54, FontWeight.w500),
                                  ))
                              : Container()
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.data.schemetype == 1
                            ? data.data.upcomingPayment.length > 1
                                ? 1
                                : data.data.upcomingPayment.length
                            : data.data.upcomingPayment.length > 2
                                ? 2
                                : data.data.upcomingPayment.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return data.data.schemetype != 1
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      boxShadow: [shadow],
                                      color: const Color(0xffFEC8D8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                rs +
                                                    data.data.monthlyAmont
                                                        .toString()
                                                        .split(".")[0],
                                                style: font(
                                                    14,
                                                    const Color(0xff856404),
                                                    FontWeight.w600),
                                              ),
                                              data.data.schemetype == 0
                                                  ? const Opacity(opacity: 0)
                                                  : Text(
                                                      "  to  $rs${data.data.amountTo.toString().split(".")[0]}",
                                                      style: font(
                                                          14,
                                                          const Color(
                                                              0xff856404),
                                                          FontWeight.w600))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Due Date  : ${DateFormat("dd, MMM-yyyy").format(DateTime.now())}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: HexColor("#856404")),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      boxShadow: [shadow],
                                      color: HexColor("#FFF3CD"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data.data.paymentType == 0
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                    rs + data.data.monthlyAmont,
                                                    style: font(
                                                        14,
                                                        const Color(0xff856404),
                                                        FontWeight.w600)))
                                            : Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Container(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 0,
                                                                    right: 6,
                                                                    top: 0,
                                                                    bottom: 0),
                                                            child: Text(
                                                                rs +
                                                                    data.data
                                                                            .monthlyAmont
                                                                            .toString()
                                                                            .split(".")[
                                                                        0],
                                                                style: font(
                                                                    14,
                                                                    const Color(
                                                                        0xff856404),
                                                                    FontWeight
                                                                        .w600))),
                                                      )),
                                                  Container(
                                                    child: Text(
                                                      " to  $rs${data.data.amountTo.toString().toString().split(".")[0]}",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                            "#856404",
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        h(3),
                                        data.data.schemetype != 1
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date :  ${DateFormat("dd-MMM-yyyy").format(data.data.upcomingPayment.elementAt(index).paymentStartDates)}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: HexColor(
                                                            "#856404")),
                                                  ),
                                                  Text(
                                                    " to ${DateFormat("dd-MMM-yyyy").format(data.data.upcomingPayment.elementAt(index).paymentEndDates)}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: HexColor(
                                                            "#856404")),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                child: Text(
                                                  "Start Date : ${DateFormat('dd  MMM, yyyy').format(DateTime.parse(DateTime.now().toString().substring(0, 10)))}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          HexColor("#856404")),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                        }),
                  ),
                  h(10),

                  h(10),
                  if (data.data.paidPayment.length != 0)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          const Text("PAYMENT HISTORY", style: smallHeading),
                          const Spacer(),
                          InkWell(
                              onTap: (() {
                                Map details = {
                                  "tittle": "Payment History",
                                  "list": data.data.paidPayment,
                                  "containerColor": "F8D7DA",
                                  "textColor": "155724",
                                  "schemeType": data.data.schemetype
                                };
                                Navigator.pushNamed(
                                    context, ListViews.routeName,
                                    arguments: details);
                              }),
                              child: Text("VIEW ALL",
                                  style: font(
                                      10, Colors.black54, FontWeight.w500)))
                        ],
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.data.paidPayment.length > 2
                            ? 2
                            : data.data.paidPayment.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          Color containerColor;
                          Color textColor;

//                   if (data.data.sheduledList.elementAt(index).status ==
//                       3) {
// // not paid
//                     containerColor = HexColor("#F8D7DA");
//                     textColor = HexColor("#721C24");

//                   }

//                   if (widget.data.data.sheduledList.elementAt(index).status ==
//                       1) {
// // on going
//                     containerColor = HexColor("#F8D7DA");
//                     textColor = HexColor("#721C24");
//                   }

//                   if (widget.data.data.sheduledList.elementAt(index).status ==
//                       0) {
// // upcoming

//                     containerColor = HexColor("#FFF3CD");
//                     textColor = HexColor("#856404");
//                   }

                          //   if (widget.data.data.sheduledList.elementAt(index).status ==
                          //        2) {
                          containerColor = HexColor("#D4EDDA");
                          textColor = HexColor("#155724");
// paid
                          //      }

                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: paymentItem(
                                  widget: widget,
                                  textColor: textColor,
                                  containerColor: containerColor,
                                  index: index,
                                  data: data),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }

  Future<bool> _onBackPressed() {
    alertAmount.clear();
    Navigator.pop(context);
  }

  nameEdit() {
    showDialog(
        context: context,
        barrierColor: Colors.white12,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: inputClr,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(accentClr),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: accentClr)))),
                  onPressed: () {
                    _nameController.text.length >= 1
                        ? saveName()
                        : showToast("PLease enter a scheme name to continue.");
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            content: TextField(
              controller: _nameController,
              cursorColor: Colors.white,
              style: font(13, Colors.white, FontWeight.w500),
              decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: accentClr)),
                  disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  hintText: 'Enter a custom scheme name !',
                  hintStyle: font(12, Colors.white54, FontWeight.w400)),
            ),
          );
        });
  }

  Future<dynamic> createOrder(amt) async {
    //------creating order id-------------------->>>>>>
    var headers = {
      'content-type': 'application/json',
      'Authorization':
          'Basic cnpwX2xpdmVfZnA0UnkxOXpzUXd5TUI6dm9OVkhGTVNoY2QzOXVJZmRGRjNjUnFm'
    };
    // var headers = {
    //   'content-type': 'application/json',
    //   'Authorization':
    //       'Basic cnpwX3Rlc3RfOGNpQ0NWOVhIWUdHM2Q6WDMyYjQ0RGxDQjRLUjFEY1Zxc1E1ckZt'
    // };
    var dataaa = json.encode({"amount": amt, "currency": "INR"});
    var dio = Dio();
    var response = await dio.request(
      'https://api.razorpay.com/v1/orders',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: dataaa,
    );
    if (response.statusCode == 200) {
      setState(() {
        payPress = false;
      });
// -------------pre-payment api-------------------->>>>>>>>>>
      Map d = {
        'UserId': await getSavedObject("roleid") == 3
            ? await getSavedObject("customerid")
            : await getSavedObject('userid'),
        'subscriptionId': await getSavedObject('subscription'),
        'scheduleddateId': paymentpendingid,
        'gram': data.data.todayEarnings.toString(),
        'amount': amt.toString(),
        'orderId': response.data["id"].toString(),
      };
      print("---------prepayyy-----------------------");
      print(d);
      print("---------prepayyy-----------------------");
      try {
        PrePaymentModel preData = await prePaymentService.prepay(d);
        print(preData.message);
        if (preData.success) {
          preNewData = preData;

          //---------------------razor pay navigation----------->>>>>>>>>>>>>>>>>

          // await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => paymentPage(
          //             total: int.parse(data.data.monthlyAmont.split('.')[0]),
          //             phone: myPhone,
          //             email: myEmail,
          //             amount: amt,
          //             gram: data.data.todayEarnings.toString(),
          //             paymntPednigId: paymentpendingid,
          //             orderID: response.data["id"].toString())));
        } else {
          print("error here");
        }
      } catch (e) {
        print(e.toString());
        showToast(e.toString());
      }
    } else {
      setState(() {
        payPress = false;
      });
      showToast("Something went wrong! Please try again.");
      print(response.data);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        agentpay(data.data.monthlyAmont, data.data.todayEarnings.toString());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Payment"),
      content: const Text("Would you like to continue with the payment?"),
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
      child: Text(
        "Cancel",
        style: font(14, Colors.white54, FontWeight.w500),
      ),
      onPressed: () {
        amountController.text = "";
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: Text(
          "Continue",
          style: font(14, Colors.white, FontWeight.bold),
        ),
        onPressed: () {
          try {
            if ((double.parse(amountController.text.toString()) <=
                    double.parse(data.data.amountTo.toString())) &&
                (double.parse(amountController.text.toString()) >=
                    double.parse(data.data.monthlyAmont.toString()))) {
              Navigator.pop(context);
              agentpay(amountController.text.toString(), finalgram);
            } else {
              showToast("Please enter amount with in range");
            }
          } catch (e) {
            showToast("Please enter amount with in range");
          }
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Payment", style: appBarTxtStyl),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: inputClr,
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter the amount to pay", style: size14_700W),
            Center(
              child: Container(
                  child: TextField(
                style: font(20, Colors.white, FontWeight.w600),
                decoration: InputDecoration(
                    hintText: "Enter amount",
                    counterText: "",
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                    // disabledBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.white54)),
                    // border: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.white54)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    prefixText: rs,
                    prefixStyle: font(20, Colors.white, FontWeight.w600),
                    hintStyle: font(14, Colors.white54, FontWeight.w500)),
                controller: amountController,
                maxLength: 8,
                onChanged: (value) {
                  setState(() {
                    print("${value}test");
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
          ],
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
      barrierColor: Colors.white24,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
    print(details);
    try {
      EasyLoading.show(status: 'Loading...');
      Paymentmodel datas = await Paymentservice.postPay(details);
      print("Reached here");
      EasyLoading.dismiss();
      //widget.paymentrefresh();
      getProfile();
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
  }

  void choosePaymentOption(
      GestureTapCallback online, GestureTapCallback offline) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12)),
        elevation: 10,
        title: const Text(
          'Choose payment option',
          style: appBarTxtStylB,
        ),
        content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: online,
                      child: Text("Online payment",
                          style: font(10, Colors.white, FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: offline,
                      child: Text("Offline payment",
                          style: font(10, Colors.white, FontWeight.w600)),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class paymentItem extends StatelessWidget {
  const paymentItem(
      {Key key,
      @required this.widget,
      @required this.textColor,
      @required this.containerColor,
      @required this.index,
      this.data})
      : super(key: key);

  final Paymentdetailswidget widget;
  final Color textColor;
  final int index;
  final Color containerColor;
  final Sheduledmodel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (data.data.schemetype != 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Date :${DateFormat("dd, MMM-yyyy").format(data.data.sheduledList.elementAt(index).paymentStartDates)}",
                      style: TextStyle(fontSize: 12, color: textColor)),
                  Text(
                      "  to  ${DateFormat("dd, MMM-yyyy").format(data.data.sheduledList.elementAt(index).paymentEndDates)}",
                      style: TextStyle(fontSize: 12, color: textColor)),
                ],
              ),
            if (data.data.schemetype == 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Date :${DateFormat("dd, MMM-yyyy").format(data.data.paidPayment.elementAt(index).updatedAt)}",
                      style: TextStyle(fontSize: 12, color: textColor)),
                ],
              ),
            if (data.data.sheduledList.elementAt(index).status == 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(children: [
                    Icon(Icons.done, color: textColor),
                    Text("PAID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor))
                  ]),
                  Container(
                      child: data.data.schemetype != 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, bottom: 2),
                              child: Column(
                                children: [
                                  data.data.sheduledList
                                              .elementAt(index)
                                              .status ==
                                          3
                                      ? Statuswidget(
                                          paid: "Not paid",
                                          colors: Colors.red[900])
                                      : data.data.sheduledList
                                                  .elementAt(index)
                                                  .status ==
                                              1
                                          ? Statuswidget(
                                              paid: "On going",
                                              colors: Colors.orange[900])
                                          : data.data.sheduledList
                                                      .elementAt(index)
                                                      .status ==
                                                  0
                                              ? Statuswidget(
                                                  paid: "Up coming",
                                                  colors: Colors.yellow[900])
                                              : Container(),
                                  Visibility(
                                    visible: data.data.sheduledList
                                            .elementAt(index)
                                            .status ==
                                        2,
                                    child: InkWell(
                                      onTap: (() {
                                        Navigator.pushNamed(
                                            context, Recepit.routeName,
                                            arguments: data.data.sheduledList
                                                .elementAt(index)
                                                .id);
                                      }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: HexColor("#C5DECB"),
                                          border:
                                              Border.all(color: Colors.black12),
                                          // Set border width

                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              "Receipt",
                                              style:
                                                  TextStyle(color: textColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Buttonwidget(
                                    //   click: () {
                                    //     Navigator.pushNamed(
                                    //         context,
                                    //         Recepit.routeName,
                                    //         arguments: widget
                                    //             .data
                                    //             .data
                                    //             .sheduledList
                                    //             .elementAt(
                                    //                 index)
                                    //             .id);
                                    //   },
                                    //   colors: "#FFD98D",
                                    //   height: 30,
                                    //   label: "Receipt",
                                    //   labelcolors: "#FFFFFF",
                                    //   width: 100,
                                    // ),
                                  ),
                                ],
                              ))
                          : Container(
                              color: containerColor,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Visibility(
                                      visible: data.data.sheduledList
                                              .elementAt(index)
                                              .status ==
                                          2,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Recepit.routeName,
                                              arguments: data.data.sheduledList
                                                  .elementAt(index)
                                                  .id);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor("#C5DECB"),
                                            // Set border width

                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                "Receipt",
                                                style:
                                                    TextStyle(color: textColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )

                                      // child: Buttonwidget(
                                      //   click: () {
                                      //     Navigator.pushNamed(
                                      //         context, Recepit.routeName,
                                      //         arguments: data
                                      //             .data.sheduledList
                                      //             .elementAt(index)
                                      //             .id);
                                      //   },
                                      //   colors: "#FFD98D",
                                      //   height: 30,
                                      //   label: "Receipt",
                                      //   labelcolors: "#FFFFFF",
                                      //   width: 100,
                                      // ),
                                      ),
                                ],
                              )))
                ],
              )
          ],
        ),
      ),
    );
  }
}

class Statuswidget extends StatelessWidget {
  final String paid;
  final Color colors;
  const Statuswidget({
    Key key,
    this.paid,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 4),
          child: Center(
            child: Text(
              paid,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
