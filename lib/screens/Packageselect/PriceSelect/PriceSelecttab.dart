import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/schemeAmountListmodel.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/Fixedpriceamount.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/VariablepriceAmount.dart';
import 'package:aradhana/service/Schemelistservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SelectpriceTab extends StatefulWidget {
  static String routeName = "/Selectprice";

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectpriceTab> {
  int schemeid;
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
        schemeid = ModalRoute.of(context).settings.arguments;
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgClr,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 18)),
          title: Text(
            "Select Amount",
            style: font(13, Colors.white, FontWeight.w600),
          ),
        ),
        body: data.data != null
            ? Container(
                // decoration: BoxDecoration(color: bgClr),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: inputClr),
                      child: TabBar(
                        unselectedLabelColor: Colors.black54,
                        labelColor: Colors.black,
                        labelStyle: font(12, Colors.white, FontWeight.w600),
                        unselectedLabelStyle:
                            font(10, Colors.white54, FontWeight.w400),
                        tabs: [
                          Text("FIXED PRICE"),
                          Text("VARIABLE PRICE"),
                        ],
                        labelPadding: EdgeInsets.symmetric(vertical: 15),
                        indicatorColor: appbarClr,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        FixedPriceAmount(
                          data: data,
                          schemeid: schemeid,
                        ),
                        VariablePriceAmount(
                          data: data,
                          schemeid: schemeid,
                        ),
                      ]),
                    )
                  ],
                ),
              )
            : Container(),
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

//---------------------------------LAYOUT---------------------

  _design1() {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        title: Text("Select Amount", style: appBarTxtStyl),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: data.data != null
          ? Column(
              children: [
                Container(
                  color: inputClr,
                  child: TabBar(
                    labelStyle: size14_400,
                    unselectedLabelStyle:
                        font(12, Colors.white54, FontWeight.w400),
                    tabs: [
                      Text("VARIABLE PRICE"),
                      Text("FIXED PRICE"),
                    ],
                    labelPadding: EdgeInsets.symmetric(vertical: 15),
                    indicatorColor: accentClr,
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    VariablePriceAmount(
                      data: data,
                      schemeid: schemeid,
                    ),
                    FixedPriceAmount(
                      data: data,
                      schemeid: schemeid,
                    ),
                  ]),
                )
                // Column(
                //   children: [
                //     Container(
                //       color: HexColor("#720755"),
                //       child: TabBar(
                //         labelColor: Colors.black,
                //         unselectedLabelColor: Colors.black,
                //         indicatorColor: HexColor("#720755"),
                //         tabs: [Text("VARIABLE PRICE"), Text("FIXED PRICE")],
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //         ),
                //         child: TabBarView(
                //           children: [
                //             // FutureBuilder(
                //             //   builder: (context,
                //             //       AsyncSnapshot<Sheduledmodel> snapshot) {
                //             //     if (snapshot.hasData) {
                //             //       return
                //
                //             //     } else {
                //             //       return Container();
                //             //     }
                //             //   },
                //             //   future: getProfile(),
                //             // ),
                //
                //             // FutureBuilder(
                //             //   builder: (context,
                //             //       AsyncSnapshot<Sheduledmodel> snapshot) {
                //             //     if (snapshot.hasData) {
                //             //       return
                //
                //             VariablePriceAmount(
                //               data: data,
                //               schemeid: schemeid,
                //             ),
                //
                //             FixedPriceAmount(
                //               data: data,
                //               schemeid: schemeid,
                //             ),
                //
                //             //     } else {
                //             //       return Container();
                //             //     }
                //             //   },
                //             //   future: getProfile(),
                //             // ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                // Expanded(
                //   child: ListView.builder(
                //       itemCount: data.data.fixed.length,
                //       itemBuilder: (BuildContext ctxt, int index) {
                //         return Padding(
                //           padding: const EdgeInsets.only(
                //               left: 20.0, right: 20, top: 15),
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(8))),
                //             child: InkWell(
                //               onTap: () {
                //                 tick(index);
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: 10.0,
                //                     right: 10,
                //                     top: 15,
                //                     bottom: 15),
                //                 child: Row(
                //                   children: [
                //                     Text("₹" +
                //                         data.data.fixed
                //                             .elementAt(index)
                //                             .amount +
                //                         " / " +
                //                         "month"),
                //                     Spacer(),
                //                     _isCheckeded.elementAt(index)
                //                         ? IconButton(
                //                             icon: FaIcon(
                //                               FontAwesomeIcons.checkCircle,
                //                               color: Colors.green,
                //                             ),
                //                             onPressed: () {
                //                               tick(index);
                //                             })
                //                         : IconButton(
                //                             icon: FaIcon(
                //                                 FontAwesomeIcons.circle,
                //                                 color: Colors.grey),
                //                             onPressed: () {
                //                               tick(index);
                //                             }),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       }),
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Checkbox(
                //           value: terms,
                //           onChanged: (val) {
                //             setState(() {
                //               terms = val;
                //             });
                //           },
                //         ),
                //         InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (context) {
                //                 return Dialog(
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius:
                //                           BorderRadius.circular(20)),
                //                   elevation: 16,
                //                   child: Container(
                //                     height:
                //                         MediaQuery.of(context).size.height,
                //                     width:
                //                         MediaQuery.of(context).size.width,
                //                     child: ListView(
                //                       children: <Widget>[
                //                         SizedBox(height: 20),
                //                         Center(
                //                           child: Text(
                //                             "Terms and conditions",
                //                             style: TextStyle(
                //                                 fontSize: 24,
                //                                 color: Theme.of(context)
                //                                     .primaryColor,
                //                                 fontWeight:
                //                                     FontWeight.bold),
                //                           ),
                //                         ),
                //                         SizedBox(height: 20),
                //                         Html(
                //                           data: data.data.termsandcondtion
                //                               .description,
                //                         ),
                //                         SizedBox(height: 20),
                //                         Padding(
                //                           padding: const EdgeInsets.only(
                //                               left: 35.0, right: 35),
                //                           child: Buttonwidget(
                //                             click: () {
                //                               Navigator.pop(context);
                //                             },
                //                             label: "Ok",
                //                             labelcolors:
                //                                 Colorsapps.buttonTextcolor,
                //                             height: 40,
                //                             width: 150,
                //                             colors: Colorsapps.buttonColor,
                //                           ),
                //                         ),
                //                         SizedBox(height: 20),
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //           child: Text(
                //             "Terms and conditions",
                //             style: TextStyle(
                //                 color: Colors.white, fontSize: 12),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 5,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 20.0),
                //       child: Buttonwidget(
                //         click: () {
                //           if (!terms) {
                //             showToast(
                //                 "Please agree to our terms conditions");
                //           } else if (priceid == null) {
                //             showToast("Please select a payment option");
                //           } else {
                //             selectScheme();

                //             // Navigator.pushNamed(
                //             //   context,
                //             //   HomeTabs.routeName,
                //             // );
                //           }
                //         },
                //         label: "Select",
                //         labelcolors: Colorsapps.buttonTextcolor,
                //         height: 50,
                //         width: 150,
                //         colors: Colorsapps.buttonColor,
                //       ),
                //     ),
                //     ],
                //   )
              ],
            )
          : Container(),
    );
  }
}
