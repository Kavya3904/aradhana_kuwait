import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/model/SchemeListModel.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/PriceSelecttab.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/yearlyscheme.dart';
import 'package:aradhana/service/Schemelistservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:random_string/random_string.dart';

class SelectPackage extends StatefulWidget {
  static String routeName = "/SelectPackage";

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  SchemeListmodel data = new SchemeListmodel();

  int schemeid;
  List<int> schemelist = new List();
  List<dynamic> shcemetypelist = new List();
  var _isCheckeded;
  SchemeList details;
  bool backkey = true;
  int role;
  int shcemetype;
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
    0xffB1BCE6,
  ];
  @override
  void initState() {
    super.initState();
    getScheme();
    getrole();
  }

  tick(int index) {
    setState(() {
      _isCheckeded.clear();
      _isCheckeded =
          List<bool>.filled(data.data.schemeList.length, false, growable: true);
      _isCheckeded.remove(index);
      _isCheckeded.insert(index, true);
      schemeid = schemelist.elementAt(index);
      shcemetype = shcemetypelist.elementAt(index);

      print("Scheme id" + schemeid.toString());
    });
  }

  Future<void> getScheme() async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      SchemeListmodel datas = await Schemelistservice.getScheme();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        EasyLoading.dismiss();
        data = datas;
        print(data);
        //  test();
      });
      _isCheckeded =
          List<bool>.filled(data.data.schemeList.length, false, growable: true);
      data.data.schemeList.forEach((element) {
        schemelist.add(element.id);
        shcemetypelist.add(element.schemeType);
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var ss = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        if (role == 2 || role == 4) {
          Navigator.pushReplacementNamed(context, SelectScheme.routeName);
          //we need to return a future
          return Future.value(false);
        } else {
          Navigator.pop(context);
          //we need to return a future
          return Future.value(false);
        }
      },
      child: _design2(),
    );
  }

  //------------------------LAYOUTS--------------------------------

  _design1() {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: bgClr,
        leading: IconButton(
            onPressed: () {
              if (role == 2 || role == 4) {
                Navigator.pushReplacementNamed(context, SelectScheme.routeName);
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            )),
        title: Text(
          "Select Package",
          style: font(14, Colors.white, FontWeight.w700),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Container(
            color: bgClr,
            padding: EdgeInsets.only(bottom: 5),
            child: newButton2("select", () {
              if (schemeid == null) {
                showToast("Please select a scheme");
              } else if (shcemetype == 1) {
                Navigator.pushNamed(context, SelectpriceTabyearly.routeName,
                    arguments: details);
                // showToast(shcemetype.toString());
              } else {
                Navigator.pushNamed(context, SelectpriceTab.routeName,
                    arguments: schemeid);
              }
            }),
          ),
        ),
      ),
      body: data.data != null
          ? SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: data.data.schemeList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return role == 2 || role == 4
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(colorArr[
                                              int.parse(randomNumeric(1))]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: InkWell(
                                        onTap: () {
                                          details = data.data.schemeList
                                              .elementAt(index);
                                          tick(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0,
                                              right: 10,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                  data.data.schemeList
                                                      .elementAt(index)
                                                      .schemeName,
                                                  style: font(14, Colors.black,
                                                      FontWeight.w600)),
                                              Spacer(),
                                              _isCheckeded.elementAt(index)
                                                  ? IconButton(
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .checkCircle,
                                                          color: Colors.green),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      })
                                                  : IconButton(
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .circle,
                                                          color: Colors.grey),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : data.data.schemeList
                                            .elementAt(index)
                                            .schemeType !=
                                        1
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20, top: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: HexColor("e3e3e3"),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: InkWell(
                                            onTap: () {
                                              details = data.data.schemeList
                                                  .elementAt(index);
                                              tick(index);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  top: 15,
                                                  bottom: 15),
                                              child: Row(
                                                children: [
                                                  Text(data.data.schemeList
                                                      .elementAt(index)
                                                      .schemeName),
                                                  Spacer(),
                                                  _isCheckeded.elementAt(index)
                                                      ? IconButton(
                                                          icon: FaIcon(
                                                            FontAwesomeIcons
                                                                .checkCircle,
                                                            color: Colors.green,
                                                          ),
                                                          onPressed: () {
                                                            details = data
                                                                .data.schemeList
                                                                .elementAt(
                                                                    index);
                                                            tick(index);
                                                          })
                                                      : IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .circle,
                                                              color:
                                                                  Colors.grey),
                                                          onPressed: () {
                                                            details = data
                                                                .data.schemeList
                                                                .elementAt(
                                                                    index);
                                                            tick(index);
                                                          }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                          }),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  _design2() {
    var ss = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgClr,
      // appBar: AppBar(
      //   backgroundColor: bgClr,
      //   leading: IconButton(
      //       onPressed: () {
      //         if (role == 2 || role == 4) {
      //           Navigator.pushReplacementNamed(
      //               context, SelectScheme.routeName);
      //         } else {
      //           Navigator.pop(context);
      //         }
      //       },
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //         size: 18,
      //       )),
      //   title: Text(
      //     "Select Package",
      //     style: font(14, Colors.white, FontWeight.w700),
      //   ),
      // ),
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 18)),
        title: Text(
          "Select Package",
          style: font(13, Colors.white, FontWeight.w600),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Container(
            color: bgClr,
            padding: EdgeInsets.only(bottom: 5),
            child: newButton("Select", () {
              if (schemeid == null) {
                showToast("Please select a scheme");
              } else if (shcemetype == 1) {
                Navigator.pushNamed(context, SelectpriceTabyearly.routeName,
                    arguments: details);
                // showToast(shcemetype.toString());
              } else {
                Navigator.pushNamed(context, SelectpriceTab.routeName,
                    arguments: schemeid);
              }
            }),
          ),
        ),
      ),
      body: data.data != null
          ? Container(
              margin: EdgeInsets.only(top: ss.height * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: bgClr),
              child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: data.data.schemeList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return role == 2 || role == 4
                        ? index == 2
                            ? Opacity(opacity: 0)
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [shadow],
                                      border: Border.all(color: Colors.black12),
                                      color: Color(colorArr[
                                          int.parse(randomNumeric(1))]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: InkWell(
                                    onTap: () {
                                      details =
                                          data.data.schemeList.elementAt(index);
                                      tick(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      child: Row(
                                        children: [
                                          _isCheckeded.elementAt(index)
                                              ? IconButton(
                                                  icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .checkCircle,
                                                      color: Colors.green),
                                                  onPressed: () {
                                                    details = data
                                                        .data.schemeList
                                                        .elementAt(index);
                                                    tick(index);
                                                  })
                                              : IconButton(
                                                  icon: FaIcon(
                                                      FontAwesomeIcons.circle,
                                                      color: Colors.grey),
                                                  onPressed: () {
                                                    details = data
                                                        .data.schemeList
                                                        .elementAt(index);
                                                    tick(index);
                                                  }),
                                          Text(
                                              data.data.schemeList
                                                  .elementAt(index)
                                                  .schemeName,
                                              style: font(12, Colors.black,
                                                  FontWeight.w600)),
                                          Spacer(),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: Icon(CupertinoIcons.circle))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("e3e3e3"),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: InkWell(
                                onTap: () {
                                  details =
                                      data.data.schemeList.elementAt(index);
                                  tick(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      top: 15,
                                      bottom: 15),
                                  child: Row(
                                    children: [
                                      Text(data.data.schemeList
                                          .elementAt(index)
                                          .schemeName),
                                      Spacer(),
                                      _isCheckeded.elementAt(index)
                                          ? IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                details = data.data.schemeList
                                                    .elementAt(index);
                                                tick(index);
                                              })
                                          : IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.circle,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                details = data.data.schemeList
                                                    .elementAt(index);
                                                tick(index);
                                              }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
            )
          : Container(),
    );
  }
}
