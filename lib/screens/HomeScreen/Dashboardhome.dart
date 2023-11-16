import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Dashboardmodel.dart' as model;
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/service/Dashboardservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class Dashboardhome extends StatefulWidget {
  static String routeName = "/Dashboardhome";
  const Dashboardhome({key}) : super(key: key);

  @override
  _DashboardhomeState createState() => _DashboardhomeState();
}

class _DashboardhomeState extends State<Dashboardhome> {
  List<String> imageList = [];
  bool updown = false;
  String gram;
  String change;
  List<String> imageList1 = [];
  int role;
  bool loaded = false;
  model.Dashboardmodel data;
  final amountController = TextEditingController();
  getrole() async {
    role = await getSavedObject("roleid");
    //number= await getSavedObject("phone");
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Container(
            color: HexColor("720755"),
            child: Scaffold(
                //  backgroundColor: HexColor("720755"),
                body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: HexColor("720755"),
                        width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.08,
                        alignment: Alignment.center,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.fitHeight,
                              ))),
                        )),
                      ),

                      Column(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * .55,

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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  child: GFCarousel(
                                    viewportFraction: 1.0,
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/fixedAssets/bg3.png"),
                                    fit: BoxFit.fitWidth,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: HexColor("2c2c2c"),

                                          // border: Border.all(
                                          //   color: Colors.red[500],
                                          // ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PER GRAM",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  "\u{20B9}" +
                                                      data.data.todayRate
                                                          .toString()
                                                          .split(".")[0],
                                                  style: goldrateText)
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "8 GRAM",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  "\u{20B9}" +
                                                      gram
                                                          .toString()
                                                          .split(".")[0],
                                                  style: goldrateText)
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                updown ? "UP" : "DOWN",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  "\u{20B9}" +
                                                      change
                                                          .toString()
                                                          .split(".")[0],
                                                  style: goldrateText)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    child: Text(storeName, style: size15_800W),
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
                        style: size12_400W,
                        trimLines: 2,
                        colorClickableText: Colors.red,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "...Show more",
                        trimExpandedText: ' \nShow less',
                        textAlign: TextAlign.left,
                        moreStyle: font(12, Color(0xffE7BF44), FontWeight.w400),
                        lessStyle:
                            font(12, Color(0xffE7BF44), FontWeight.w400)),
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
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor("00a951"),
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
                                      color: HexColor("00a951"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.download,
                                    color: HexColor("00a951"),
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
    try {
      EasyLoading.show(status: 'Loading...');
      //showLoading(context);
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
