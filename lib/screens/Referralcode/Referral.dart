import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Referralmodel.dart';
import 'package:aradhana/service/Referralservice.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hexcolor/hexcolor.dart';

class Referral extends StatefulWidget {
  static String routeName = "/Referral";
  @override
  _ReferralState createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  int item;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title: Text("Referral Code", style: appBarTxtStyl),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<Referralmodel> snapshot) {
          if (snapshot.hasData) {
            {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: inputClr,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Refer & Earn!",
                                            style: font(20, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          h(10),
                                          Text(
                                            "Total Points Earned",
                                            style: size12_400,
                                          ),
                                          Text(
                                              snapshot.data.data.referal.point
                                                          .toString()
                                                          .compareTo("null") ==
                                                      0
                                                  ? "0"
                                                  : snapshot
                                                      .data.data.referal.point
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/fixedAssets/gift.png",
                                      height: 60,
                                      width: 60,
                                    )
                                  ],
                                ),
                                h(15),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff5A4F4F)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Your Code",
                                          style: font(12, Colors.white,
                                              FontWeight.w400),
                                        ),
                                        Expanded(
                                            child: Text(
                                          snapshot.data.data.referal.referalId,
                                          textAlign: TextAlign.center,
                                          style: font(15, Colors.white,
                                              FontWeight.bold),
                                        )),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      new ClipboardData(
                                                          text: snapshot
                                                              .data
                                                              .data
                                                              .referal
                                                              .referalId));
                                                  showToast("reference copied");
                                                },
                                                padding: EdgeInsets.zero,
                                                icon: Icon(Icons.copy,
                                                    color: Colors.white,
                                                    size: 18)),
                                            IconButton(
                                                onPressed: () {
                                                  share(snapshot.data.data
                                                      .referal.referalId
                                                      .toString());
                                                },
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 18,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                h(15),
                                GestureDetector(
                                  onTap: () async {
                                    await share(snapshot
                                        .data.data.referal.referalId
                                        .toString());
                                  },
                                  child: DottedBorder(
                                    color: Colors.black,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                  "assets/appIcon.jpg",
                                                ))),
                                          ),
                                          w(15),
                                          Text("Share this app with friends!",
                                              style: size12_400),
                                          Spacer(),
                                          Icon(Icons.share, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 15),
                    //   child: Card(
                    //       elevation: 5,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       color: HexColor("#D4EDDA"),
                    //       child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 15.0, right: 15, top: 10, bottom: 10),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(top: 0.0),
                    //                     child: Text(
                    //                       "Total Points",
                    //                       style: TextStyle(
                    //                         fontWeight: FontWeight.w500,
                    //                         color: HexColor("#000000"),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(bottom: 0),
                    //                     child: Text(
                    //                       "Earned",
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.w500,
                    //                           color: HexColor("#000000")),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(bottom: 0),
                    //                     child: Text(
                    //                         snapshot.data.data.referal.point
                    //                                     .toString()
                    //                                     .compareTo("null") ==
                    //                                 0
                    //                             ? "0"
                    //                             : snapshot
                    //                                 .data.data.referal.point
                    //                                 .toString(),
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.w600,
                    //                             fontSize: 18,
                    //                             color: HexColor("#000000"))),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Spacer(),
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.end,
                    //                 children: [
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(bottom: 0),
                    //                     child: Text(
                    //                       "Referral Code ",
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.w500,
                    //                           color: HexColor("#000000")),
                    //                     ),
                    //                   ),
                    //
                    //                   //   Padding(
                    //                   //   padding: const EdgeInsets.only(bottom: 5),
                    //                   //   child: Text("Balance",style: TextStyle(fontWeight: FontWeight.w500,color: HexColor("#000000")),),
                    //                   // ),
                    //
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.center,
                    //                     children: [
                    //                       // Padding(
                    //                       //   padding: const EdgeInsets.only(
                    //                       //       bottom: 15, right: 3),
                    //                       //   child: Container(
                    //                       //       child: Image.asset(
                    //                       //     "assets/goldcoin.png",
                    //                       //     fit: BoxFit.fill,
                    //                       //   )),
                    //                       // ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           Clipboard.setData(
                    //                               new ClipboardData(
                    //                                   text: snapshot.data.data
                    //                                       .referal.referalId));
                    //                           showToast("reference copied");
                    //                         },
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               bottom: 0),
                    //                           child: Container(
                    //                             //     decoration: BoxDecoration(
                    //                             //  border: Border.all(color:  HexColor("#FFD98D"))
                    //                             //        ),
                    //                             child: Padding(
                    //                               padding:
                    //                                   const EdgeInsets.all(5.0),
                    //                               child: Text(
                    //                                   snapshot.data.data.referal
                    //                                       .referalId,
                    //                                   style: TextStyle(
                    //                                       fontWeight:
                    //                                           FontWeight.w600,
                    //                                       fontSize: 15,
                    //                                       color: HexColor(
                    //                                           "#000000"))),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //
                    //                       IconButton(
                    //                           icon: Icon(
                    //                             Icons.copy,
                    //                             color: Colors.black,
                    //                           ),
                    //                           onPressed: () {
                    //                             Clipboard.setData(
                    //                                 new ClipboardData(
                    //                                     text: snapshot
                    //                                         .data
                    //                                         .data
                    //                                         .referal
                    //                                         .referalId));
                    //                             showToast("References copied");
                    //                           }),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ))),
                    // ),
                    div,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text("REFERENCE LIST", style: smallHeading),
                    ),
                    (snapshot.data.data.referedList.length == 0)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 120.0),
                            child: Center(
                                child: Text(
                              "Sorry you didn't referred anyone yet.",
                              style: TextStyle(color: Colors.black),
                            )),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.referedList.length,
                            itemBuilder: (BuildContext ctxt, item) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTileTheme(
                                  tileColor: Colors.grey.shade300,
                                  child: ExpansionTileCard(
                                      baseColor: HexColor("e3e3e3"),
                                      expandedColor: HexColor("e3e3e3"),
                                      contentPadding: EdgeInsets.zero,
                                      finalPadding: EdgeInsets.zero,
                                      initialPadding: EdgeInsets.zero,
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15,
                                            top: 20,
                                            bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0.0),
                                                    child: Text(
                                                      snapshot
                                                          .data.data.referedList
                                                          .elementAt(item)
                                                          .name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            HexColor("#000000"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    snapshot
                                                        .data.data.referedList
                                                        .elementAt(item)
                                                        .phone,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: HexColor(
                                                            "#000000")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: <Widget>[
                                        Divider(
                                          thickness: 1.0,
                                          height: 1.0,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .data.data.referedList
                                                .elementAt(item)
                                                .paymentDates
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text("Expire on "),
                                                      Spacer(),
                                                      Text(
                                                        snapshot.data.data
                                                            .referedList
                                                            .elementAt(item)
                                                            .paymentDates
                                                            .elementAt(index)
                                                            .paymentEndDates
                                                            .toString()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ]),
                                ),
                              );
                            }),
                  ],
                ),
              );
            }
          } else {
            return Container();
          }
        },
        future: getPaymentdetails(),
      ),
    );
  }

  Future<void> share(code) async {
    // if (Platform.isAndroid) {
    await FlutterShare.share(
      title: 'Refer & Earn',
      text: 'Welcome to Aradhana Jewellery Kannur! Use my referral code "' +
          code +
          '"',
      linkUrl:
          'For android users : https://rb.gy/a46fz \n For IOS users: https://rb.gy/xra3s ',
    );
    // } else {
    //   await FlutterShare.share(
    //     title: 'Refer & Earn',
    //     text: 'Welcome to Aradhana Jewellery Kannur! Use my referral code "' +
    //         code +
    //         '"',
    //     linkUrl:
    //         'https://apps.apple.com/in/app/aradhana-jewellery/id6449661095',
    //   );
    // }
  }

  Future<Referralmodel> getPaymentdetails() async {
    Referralmodel datas;
    int userid;
    try {
      userid = await getSavedObject("userid");
      //showLoading(context);
      EasyLoading.show(status: 'Loading...');
      print(userid);
      datas = await Referralservice.getReferralservice(userid);
      print("Reached here");
      //  Navigator.of(context).pop(true);
      //  showLoading(context);
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
}
