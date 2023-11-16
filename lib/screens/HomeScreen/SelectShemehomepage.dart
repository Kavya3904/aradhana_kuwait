import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Subscriptionlistmodel.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/screens/Packageselect/Selectpackage.dart';
import 'package:aradhana/service/Schemelistgetservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:random_string/random_string.dart';

class SelectScheme extends StatefulWidget {
  static String routeName = "/SelectScheme";
  @override
  _SelectSchemeState createState() => _SelectSchemeState();
}

class _SelectSchemeState extends State<SelectScheme> {
  int subid;

  List<int> subidlist = new List();
  int role;
  getrole() async {
    role = await getSavedObject("roleid");
  }

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
    0xffB1BCE6
  ];

  var randomDigit = randomNumeric(1);
  // @override
  void initState() {
    super.initState();
    getScheme();
  }

  Subscriptionlistmodel data = new Subscriptionlistmodel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      body: data.data != null
          ? SafeArea(
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 20.0, right: 20, top: 20, bottom: 20),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: HexColor("#FFCF5E"),
                  //         borderRadius: BorderRadius.all(Radius.circular(8))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 10.0, right: 10, top: 10, bottom: 10),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "Create new plan",
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.white),
                  //           ),
                  //           Spacer(),

                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 20.0, right: 20, top: 10, bottom: 10),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: HexColor("#FFCF5E"),
                  //         borderRadius: BorderRadius.all(Radius.circular(8))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 10.0, right: 10, top: 20, bottom: 20),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "CREATE NEW PLAN",
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.white),
                  //           ),
                  //           Spacer(),
                  //           IconButton(
                  //               icon: Icon(
                  //                 Icons.add,
                  //                 color: Colors.white,
                  //               ),
                  //               onPressed: () {
                  //                 Navigator.pushReplacementNamed(
                  //                     context, SelectPackage.routeName);
                  //               })
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0, top: 10),
                  //   child: Text(
                  //     "CHOOSE PLAN",
                  //     style: TextStyle(color: HexColor("#FECC5F")),
                  //   ),
                  // ),
                  Expanded(
                    child: data.data.subscriptionList.isEmpty
                        ? Center(
                            child: Text(
                            "No scheme selected \n Please select a scheme",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            textAlign: TextAlign.center,
                          ))
                        : ListView.builder(
                            itemCount: data.data.subscriptionList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [shadow],
                                      border: Border.all(color: Colors.black12),
                                      color: Color(colorArr[
                                          int.parse(randomNumeric(1))]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: InkWell(
                                    onTap: () async {
                                      await saveObject("subscription",
                                          subidlist.elementAt(index));
                                      Navigator.pushReplacementNamed(
                                        context,
                                        HomeTabs.routeName,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.data.subscriptionList
                                                    .elementAt(index)
                                                    .schemeName
                                                    .toString(),
                                                style: font(14, Colors.black,
                                                    FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              data.data.subscriptionList
                                                          .elementAt(index)
                                                          .subscriptionType ==
                                                      0
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: HexColor(
                                                              "#720755"),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 7.0,
                                                                right: 7),
                                                        child: Text(
                                                          rs +
                                                              data.data
                                                                  .subscriptionList
                                                                  .elementAt(
                                                                      index)
                                                                  .schemAmount
                                                                  .toString()
                                                                  .split(
                                                                      '.')[0],
                                                          style: font(
                                                              12,
                                                              Colors.white,
                                                              FontWeight.w500),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  "#720755"),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        3),
                                                            child: Text(
                                                              rs +
                                                                  data.data
                                                                      .subscriptionList
                                                                      .elementAt(
                                                                          index)
                                                                      .schemAmount
                                                                      .toString()
                                                                      .split(
                                                                          '.')[0],
                                                              style: font(
                                                                  12,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          " To ",
                                                          style: font(
                                                              12,
                                                              Colors.black,
                                                              FontWeight.bold),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  "#720755"),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        3),
                                                            child: Text(
                                                              rs +
                                                                  data.data
                                                                      .subscriptionList
                                                                      .elementAt(
                                                                          index)
                                                                      .amountTo
                                                                      .toString()
                                                                      .split(
                                                                          '.')[0],
                                                              style: font(
                                                                  12,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            )
          : Container(),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 20.0, bottom: 15),
      //   child: Container(
      //     width: 64,
      //     height: 64,
      //     child: FloatingActionButton(
      //         onPressed: () {
      //           {
      //             Navigator.pushNamed(context, SelectPackage.routeName)
      //                 .then((value) => getScheme());
      //           }
      //         },
      //         child: const Icon(
      //           Icons.add,
      //           size: 30,
      //         ),
      //         backgroundColor: HexColor("#FFCD5E")),
      //   ),
      // ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, SelectPackage.routeName)
              .then((value) => getScheme());
        },
        backgroundColor: accentClr,
        label: Text(
          'New Scheme',
          style: font(13, Colors.black, FontWeight.w600),
        ),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Future<void> getScheme() async {
    int userid;
    subidlist.clear();
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
      setState(() {
        data = datas;
        print(data);
        //  test();
      });
      data.data.subscriptionList.forEach((element) {
        subidlist.add(element.id);
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
