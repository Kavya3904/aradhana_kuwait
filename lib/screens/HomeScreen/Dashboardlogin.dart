import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/loginDrawer.dart';
import 'package:aradhana/model/BranchListModel.dart';
import 'package:aradhana/model/Dashboardmodel.dart' as model;
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Login/Login.dart';
import 'package:aradhana/service/Dashboardservice.dart';
import 'package:aradhana/service/branchservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class Dashboardlogin extends StatefulWidget {
  static String routeName = "/Dashboardlogin";

  const Dashboardlogin({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboardlogin> {
  List<String> imageList = [];
  List<String> imageList1 = [];
  List<int> branchid = [];
  var branchhh;
  bool loaded = false;
  model.Dashboardmodel data;

  bool updown = false;
  String gram;
  String change;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Container(
            color: bgClr,
            child: Scaffold(
                appBar: AppBar(
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: IconButton(
                          icon: Icon(Icons.sort, size: 30),
                          onPressed: () {
                            loginDrawer(context);
                            // Scaffold.of(context).openDrawer();
                          }),
                    ),
                  ),
                  centerTitle: true,
                  title:
                      Image.asset("assets/logoOnly.png", height: 40, width: 40),
                ),
                backgroundColor: bgClr,
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 0, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      h(10),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, videoPage.routeName);
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(Icons.video_collection_sharp,
                      //           color: Colors.black, size: 15),
                      //       w(5),
                      //       Text(
                      //         "How to use?",
                      //         style: TextStyle(
                      //             fontSize: 12,
                      //             color: Colors.black,
                      //             decoration: TextDecoration.underline),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // h(10),
                      // TextButton(onPressed: () {}, child: Text("How to use?")),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Login.routeName);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: goldenUpDownGradient,
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Register Now".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
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
                                                                      .todayRate
                                                                      .toString(),
                                                              style: font(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w500))
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
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       child: InkWell(
                      //         // onTap: () async {
                      //         //   if (await canLaunch(
                      //         //       "https://www.proaims.in/")) {
                      //         //     await launch(
                      //         //         "https://www.proaims.in/");
                      //         //   } else {
                      //         //     throw 'Could not launch "https://www.proaims.in/';
                      //         //   }
                      //         // },
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(
                      //
                      //               // bottom: 15,
                      //               ),
                      //           child: ClipRRect(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(0)),
                      //             child: GFCarousel(
                      //               viewportFraction: 1.0,
                      //               activeIndicator: Colors.white,
                      //               passiveIndicator: Colors.black,
                      //               hasPagination: true,
                      //               autoPlay: true,
                      //               items: imageList.map(
                      //                 (item) {
                      //                   return Container(
                      //                     margin: EdgeInsets.all(0.0),
                      //                     child: ClipRRect(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(0.0)),
                      //                       child: Image.network(
                      //                           ApiConfigs.imageurls + item,
                      //                           fit: BoxFit.cover,
                      //                           width: MediaQuery.of(context)
                      //                               .size
                      //                               .width),
                      //                     ),
                      //                   );
                      //                 },
                      //               ).toList(),
                      //               //   onPageChanged: (index) {
                      //               //     setState(() {
                      //               //       index;
                      //               //     });
                      //               //   },
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(
                      //           left: 15, right: 15, bottom: 10, top: 5),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             image: DecorationImage(
                      //               image: AssetImage("assets/bg3.png"),
                      //               fit: BoxFit.fitWidth,
                      //             )),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             children: [
                      //               Container(
                      //                 decoration: BoxDecoration(
                      //                     color: HexColor("2c2c2c"),
                      //
                      //                     // border: Border.all(
                      //                     //   color: Colors.red[500],
                      //                     // ),
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(20))),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       left: 18.0,
                      //                       right: 18,
                      //                       top: 4,
                      //                       bottom: 4),
                      //                   child: Text(
                      //                     "Today's Gold Rate",
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         color: Color.fromRGBO(
                      //                             236, 236, 236, 1),
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 10.0, right: 10),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           "PER GRAM",
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 13,
                      //                               fontWeight:
                      //                                   FontWeight.w500),
                      //                         ),
                      //                         Text(
                      //                           "\u{20B9}" +
                      //                               data.data.todayRate
                      //                                   .toString()
                      //                                   .split(".")[0],
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 19,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         )
                      //                       ],
                      //                     ),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           "8 GRAM",
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 13,
                      //                               fontWeight:
                      //                                   FontWeight.w500),
                      //                         ),
                      //                         Text(
                      //                           "\u{20B9}" +
                      //                               gram
                      //                                   .toString()
                      //                                   .split(".")[0],
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 19,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         )
                      //                       ],
                      //                     ),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           updown ? "UP" : "DOWN",
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 13,
                      //                               fontWeight:
                      //                                   FontWeight.w500),
                      //                         ),
                      //                         Text(
                      //                           "\u{20B9}" +
                      //                               change
                      //                                   .toString()
                      //                                   .split(".")[0],
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 19,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     // Center(
                      //     //   child: Padding(
                      //     //     padding: const EdgeInsets.all(8.0),
                      //     //     child: ElevatedButton(
                      //     //       style: ButtonStyle(
                      //     //         shape: MaterialStateProperty.all<
                      //     //                 RoundedRectangleBorder>(
                      //     //             RoundedRectangleBorder(
                      //     //           borderRadius: BorderRadius.circular(18.0),
                      //     //         )),
                      //     //         padding: MaterialStateProperty.all(
                      //     //             EdgeInsets.all(12)),
                      //     //         backgroundColor: MaterialStateProperty.all(
                      //     //             Color.fromRGBO(167, 116, 27, 1)),
                      //     //       ),
                      //     //       child: Text(
                      //     //         "Scheme Brochure",
                      //     //         style: TextStyle(
                      //     //             color: Colors.white,
                      //     //             fontWeight: FontWeight.w500),
                      //     //       ),
                      //     //       onPressed: ()
                      //     //        {
                      //     //         Navigator.of(context)
                      //     //             .pushNamed(Brochure.routeName);
                      //     //       },
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
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
                                  child: Image.network(
                                      ApiConfigs.imageurls + item,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: ReadMoreText(
                            data.data.bannerContent.bannerContent.toString(),
                            //data.data.schemeDetails.description.toString(),
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
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10,),
                      //   child:   Center(
                      //     child:   Container(
                      //     width: MediaQuery.of(context).size.width,
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: Image.asset("assets/bangle.png",fit:BoxFit.cover ,))),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),

                      Visibility(
                        visible: false,
                        child: InkWell(
                          onTap: () {
                            //        Navigator.of(context).pushNamed(Brochure.routeName);
                          },
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor("720755"),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Brochure",
                                        style: TextStyle(
                                          color: HexColor("720755"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.download,
                                        color: HexColor("720755"),
                                        size: 14,
                                      )
                                    ],
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
                )),
          )
        : Scaffold(
            body: Container(),
          );
  }

  Future<model.Dashboardmodel> getUserDetails() async {
    branchid.clear();
    try {
      EasyLoading.show(status: 'Loading...');
      //showLoading(context);
      BranchListModel branchs = await Branchservice.getBranch();
      setState(() {
        branchid = branchs.data.branches.map((e) => e.id).toList();
      });
      branchhh = branchid[0];
      print(branchhh);
      model.Dashboardmodel datas = await Dashbordservice.getDashboard();

      EasyLoading.dismiss();

      if (datas.success) {
        print(datas.message);
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
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
