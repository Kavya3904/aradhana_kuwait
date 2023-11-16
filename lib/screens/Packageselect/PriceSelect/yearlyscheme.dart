import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/model/SchemeListModel.dart';
import 'package:aradhana/model/Schemeaddmodel.dart';
import 'package:aradhana/model/schemeAmountListmodel.dart';
import 'package:aradhana/service/Schemelistservice.dart';
import 'package:aradhana/service/postSchemeService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';

class SelectpriceTabyearly extends StatefulWidget {
  static String routeName = "/Selectpriceyearly";

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectpriceTabyearly> {
  //    "scheme_type": 1,
  //               "check_payment_interval": 10,
  //               schemeid

  SchemeList details;
  int schemeid;
  int termindex = 0;

  SchemeAmountListmodel data = new SchemeAmountListmodel();

  int role;

  getrole() async {
    role = await getSavedObject("roleid");
  }

  int priceid;
  List<int> pricelist = new List();
  var _isCheckeded;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        details = ModalRoute.of(context).settings.arguments;
        schemeid = details.id;
      });
      getAmount();
      //  getrole();
    });
  }

  getAmount() async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      SchemeAmountListmodel datas =
          await Schemelistservice.schemeAmount(schemeid.toString());
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        EasyLoading.dismiss();
        data = datas;
        print(data);
        //  test();
      });
      _isCheckeded =
          List<bool>.filled(data.data.fixed.length, false, growable: true);
      data.data.fixed.forEach((element) {
        pricelist.add(element.id);
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  // bool terms = false;

  // tick(int index) {
  //   setState(() {
  //     _isCheckeded.clear();
  //     _isCheckeded = List<bool>.filled(data.data.fixed.length, false,
  //         growable: true);
  //     _isCheckeded.remove(index);
  //     _isCheckeded.insert(index, true);
  //     priceid = pricelist.elementAt(index);
  //     print(priceid);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var ss = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgClr,
      // appBar: AppBar(
      //   backgroundColor: bgClr,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //         size: 18,
      //       )),
      //   title: Text(
      //     "Select Amount",
      //     style: font(14, Colors.white, FontWeight.w700),
      //   ),
      // ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: BoxDecoration(gradient: goldenUpDownGradient),
                height: ss.height * 0.2,
                child: Text("       Select Amount", style: size16_400)),
          ),
          Container(
            margin: EdgeInsets.only(top: ss.height * 0.15),
            decoration: BoxDecoration(
                color: bgClr,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
            child: data.data != null
                ? VariablePriceAmount(
                    data: data,
                    schemeid: schemeid,
                    details: details,
                  )
                : Opacity(opacity: 0),
          ),
        ],
      ),
    );
  }

//   void selectScheme() async {
//     DateTime now = new DateTime.now();
//     //  DateTime date = new DateTime(now.day, now.month, now.year);

//     Map details = {
//       "SchemeId": schemeid,
//       "SchemeAmountId": priceid,
//       "UserId": await getSavedObject("roleid") == 3
//           ? await getSavedObject("customerid")
//           : await getSavedObject("userid"),
//       "StartDate": now.toString().substring(0, 10)
//     };
//     try {
//       print(details);
//       EasyLoading.show(status: 'Loading...');
//       //    showLoading(context);
//       Schemeaddmodel datas = await PostSchemeService.postService(details);
//       //  Navigator.of(context).pop(true);
//       // showLoading(context);
//       setState(() {
//         EasyLoading.dismiss();
//         // data = datas;
//         // print(data);
//         //  test();
//       });
//       if (datas.success) {
//         if (await getSavedObject("roleid") == 2 || await getSavedObject("roleid") == 4)
//         {
//  //Navigator.popUntil(context, ModalRoute.withName('/SelectScheme'));
//         // Navigator.popUntil(context, ModalRoute.withName('/SelectScheme'));
//           Navigator.of(context).pushNamedAndRemoveUntil(
//               '/SelectScheme', (Route<dynamic> route) => false);
//         } else
//         {
//           Navigator.popUntil(context, ModalRoute.withName('/Customerschemedetails'));
//         }
//       }
//     } catch (e) {
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       //  Navigator.pop(context);
//     }

//     print(details);
//   }
}

class VariablePriceAmount extends StatefulWidget {
  final SchemeAmountListmodel data;
  final int schemeid;
  final SchemeList details;

  const VariablePriceAmount({Key key, this.data, this.schemeid, this.details})
      : super(key: key);
  @override
  _VariablePriceAmountState createState() => _VariablePriceAmountState();
}

class _VariablePriceAmountState extends State<VariablePriceAmount> {
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
  int termssId;

  bool terms = false;
  int priceid;
  List<int> pricelist = [];
  var _isCheckeded;
  String _chosenValue = "Gold";
  int termindex = 0;

  tick(int index) {
    setState(() {
      _isCheckeded.clear();
      _isCheckeded = List<bool>.filled(widget.data.data.varient.length, false,
          growable: true);
      _isCheckeded.remove(index);
      _isCheckeded.insert(index, true);
      priceid = pricelist.elementAt(index);
      termssId = widget.data.data.varient.elementAt(index).termsId;
    });
    for (int i = 0; i < widget.data.data.termsandcondtion.length; i++) {
      if (widget.data.data.termsandcondtion.elementAt(i).id ==
          widget.data.data.varient.elementAt(index).termsId) {
        termindex = i;
      }
    }
  }

  @override
  void initState() {
    _isCheckeded = List<bool>.filled(widget.data.data.varient.length, false,
        growable: true);
    widget.data.data.varient.forEach((element) {
      pricelist.add(element.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.data.data.varient.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(colorArr[int.parse(randomNumeric(1))]),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: InkWell(
                      onTap: () {
                        tick(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                "The amount deposited during half the period of total duration will be the limit for next half",
                                style: font(12, Colors.black, FontWeight.w400),
                              ),
                            ),
                            Spacer(),
                            _isCheckeded.elementAt(index)
                                ? IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.checkCircle,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      tick(index);
                                    })
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.circle,
                                        color: Colors.grey),
                                    onPressed: () {
                                      tick(index);
                                    }),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.black,
                  ),
                  child: Checkbox(
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    value: terms,
                    onChanged: (val) {
                      setState(() {
                        terms = val;
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Terms and conditions"),
                          titleTextStyle:
                              font(15, Colors.black, FontWeight.w500),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: newButton("Ok", () {
                                Navigator.pop(context);
                              }),
                            )
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 16,
                          content: Scrollbar(
                            child: ListView(
                              children: [
                                Html(
                                  data: widget.data.data.termsandcondtion
                                      .elementAt(termindex)
                                      .description,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: 2, // Space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.blue,
                      width: 1.0, // Underline thickness
                    ))),
                    child: Text(
                      "Terms and conditions",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: newButton("select", () {
                if (!terms) {
                  showToast("Please agree to our terms conditions");
                } else if (priceid == null) {
                  showToast("Please select a payment option");
                } else {
                  selectScheme();

                  // Navigator.pushNamed(
                  //   context,
                  //   HomeTabs.routeName,
                  // );
                }
              }),
            ),
            // NeumorphicButton(
            //     style: NeumorphicStyle(
            //       depth: 0,
            //       // lightSource: LightSource.topLeft,
            //       shadowLightColor: Color.fromRGBO(71, 77, 110, 1),
            //       shadowDarkColor: Color.fromRGBO(71, 77, 110, 1),
            //       color: Colors.white,
            //       shape: NeumorphicShape.concave,
            //       boxShape:
            //           NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
            //     ),
            //     padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            //     child: Icon(
            //       Icons.check_outlined,
            //       size: 35.0,
            //       color: Colors.black,
            //     ),
            //     onPressed: () {
            //       if (!terms) {
            //         showToast("Please agree to our terms conditions");
            //       } else if (priceid == null) {
            //         showToast("Please select a payment option");
            //       } else {
            //         selectScheme();
            //
            //         // Navigator.pushNamed(
            //         //   context,
            //         //   HomeTabs.routeName,
            //         // );
            //       }
            //     }),
            SizedBox(
              height: 20,
            )

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: Buttonwidget(
            //     click: () {
            //       if (!terms) {
            //         showToast("Please agree to our terms conditions");
            //       } else if (priceid == null) {
            //         showToast("Please select a payment option");
            //       } else {
            //         _showRedeemOption();

            //         // Navigator.pushNamed(
            //         //   context,
            //         //   HomeTabs.routeName,
            //         // );
            //       }
            //     },
            //     label: "Select",
            //     labelcolors: Colorsapps.buttonTextcolor,
            //     height: 50,
            //     width: 150,
            //     colors: Colorsapps.buttonColor,
            //   ),
            // ),
          ],
        )
      ],
    );
  }

  void selectScheme() async {
    DateTime now = new DateTime.now();
    //  DateTime date = new DateTime(now.day, now.month, now.year);

    Map details = {
      "SchemeId": widget.schemeid,
      "SchemeAmountId": priceid,
      "scheme_type": widget.details.schemeType,
      "check_payment_interval": widget.details.paymentIntervel,
      "UserId": await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject("userid"),
      "StartDate": now.toString().substring(0, 10),
      //  "redeem_type": _chosenValue.compareTo("Gold") == 0 ? "0" : "1",
      "subscription_type": "1",
      "termsId": termssId
    };
    try {
      print(details);
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Schemeaddmodel datas = await PostSchemeService.postService(details);
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        EasyLoading.dismiss();
        // data = datas;
        // print(data);
        //  test();
      });
      if (datas.success) {
        if (await getSavedObject("roleid") == 2 ||
            await getSavedObject("roleid") == 4) {
          //Navigator.popUntil(context, ModalRoute.withName('/SelectScheme'));
          // Navigator.popUntil(context, ModalRoute.withName('/SelectScheme'));
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/SelectScheme', (Route<dynamic> route) => false);
        } else {
          Navigator.popUntil(
              context, ModalRoute.withName('/Customerschemedetails'));
        }
      }
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }

    print(details);
  }

  // void _showRedeemOption() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //             title: new Text("Gold redeem option"),
  //             content: Container(
  //               width: 200,
  //               child: ListView(
  //                 shrinkWrap: true,
  //                 children: <Widget>[
  //                   new Text("Please select any option"),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   InputDecorator(
  //                     decoration: const InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         contentPadding: EdgeInsets.only(
  //                             left: 10, right: 10, top: 0, bottom: 0)),
  //                     child: DropdownButtonHideUnderline(
  //                       child: new DropdownButton<String>(
  //                         value: _chosenValue,
  //                         underline: Container(),
  //                         items: <String>["Gold", "Cash"].map((String value) {
  //                           return new DropdownMenuItem<String>(
  //                             value: value,
  //                             child: new Text(
  //                               value,
  //                               style: TextStyle(fontWeight: FontWeight.w500),
  //                             ),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String value) {
  //                           setState(() {
  //                             _chosenValue = value;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Buttonwidget(
  //                     click: () {
  //                       selectScheme();

  //                       // Navigator.pushNamed(
  //                       //   context,
  //                       //   HomeTabs.routeName,
  //                       // );
  //                     },
  //                     label: "Select",
  //                     labelcolors: Colorsapps.buttonTextcolor,
  //                     height: 50,
  //                     width: 150,
  //                     colors: Colorsapps.buttonColor,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
