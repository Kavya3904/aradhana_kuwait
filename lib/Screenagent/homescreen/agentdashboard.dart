import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/homescreen/agentab.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Dashboardmodel.dart' as model;
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/service/Dashboardservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class AgentDashboardhome extends StatefulWidget {
  static String routeName = "/AgentDashboardhome";
  const AgentDashboardhome({key}) : super(key: key);

  @override
  _DashboardhomeState createState() => _DashboardhomeState();
}

class _DashboardhomeState extends State<AgentDashboardhome> {
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
            color: bgClr,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title:
                      Image.asset("assets/logoOnly.png", height: 40, width: 40),
                ),
                backgroundColor: bgClr,
                bottomNavigationBar: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Agentab.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: themeRed,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View Customers",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
                                                                  20,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold))
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
                                                              style: font(
                                                                  20,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold))
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
                                                                              ".")[
                                                                      0],
                                                              style: font(
                                                                  20,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold))
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
                      div,
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, bottom: 10),
                        child: Text(storeName, style: size15_800),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 15,
                          right: 15,
                          bottom: 8,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                        BorderRadius.all(Radius.circular(0.0)),
                                    child: Image.network(
                                        ApiConfigs.imageurls + item,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width),
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

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 5,
                          bottom: 10,
                        ),
                        child: ReadMoreText(
                          data.data.bannerContent.bannerContent.toString(),
                          //data.data.schemeDetails.description.toString(),
                          style: TextStyle(color: Colors.black),
                          trimLines: 2,
                          colorClickableText: Colors.black,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "...Show more",
                          trimExpandedText: ' \nShow less',
                          textAlign: TextAlign.left,
                          moreStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          lessStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
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
                            //   Navigator.of(context).pushNamed(Brochure.routeName);
                          },
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
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
