import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/homescreen/agenthomescreen.dart';
import 'package:aradhana/Screenagent/homescreen/agentnextpaymentcustomer.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/AgentDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Agentab extends StatefulWidget {
  static String routeName = "/Agentab";

  @override
  _AgentabState createState() => _AgentabState();
}

class _AgentabState extends State<Agentab> {
  //StreamController<Agentcustomermodel> _dataStream;
  // Stream broadcastStream;
  //TabController _tabController;
  String agentid = "";
  getAgent() async {
    String s = await getSavedObject("referalId");
    if (s != null)
      setState(() {
        agentid = s;
      });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _controller;
  @override
  void initState() {
    super.initState();
    getAgent();
    // getCustomerlist();
    //   _dataStream = StreamController<Agentcustomermodel>();
    //   broadcastStream = _dataStream.stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //       appBar: AppBar(
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 10.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text("Reference ID :",
    //                     style: TextStyle(color: Colors.white)),
    //                 Text(
    //                   agentid,
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.w600, color: Colors.white),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           IconButton(
    //               icon: Icon(Icons.copy, color: Colors.white),
    //               onPressed: () {
    //                 Clipboard.setData(new ClipboardData(text: agentid));
    //                 showToast("References copied");
    //               })
    //         ],
    //         leading: IconButton(
    //             icon: Icon(Icons.menu),
    //             onPressed: () {
    //               _scaffoldKey.currentState.openDrawer();
    //             }),
    //       ),
    //       key: _scaffoldKey,
    //       drawer: AgentDrawer(),
    //       body: Column(
    //         children: [
    //           Container(
    //             height: 50,
    //             color: Colors.white70,
    //             child: TabBar(
    //               labelColor: Colors.black,
    //               indicator: BoxDecoration(color: accentClr),
    //               unselectedLabelColor: Colors.white70,
    //               labelStyle: font(14, Colors.black, FontWeight.w800),
    //               unselectedLabelStyle:
    //                   font(12, Colors.white70, FontWeight.w400),
    //               indicatorColor: Colors.red,
    //               indicatorWeight: 5,
    //               tabs: [
    //                 Text("All Customers",
    //                     style: TextStyle(color: Colors.black)),
    //                 Text("Next Payment", style: TextStyle(color: Colors.black))
    //               ],
    //             ),
    //           ),
    //           Container(color: Colors.white, height: 1, width: double.infinity),
    //           Expanded(
    //             child: TabBarView(
    //               controller: _controller,
    //               children: [
    //                 Agenthomescreen(),
    //                 Agentnextpaymentcustomer(),
    //               ],
    //             ),
    //           ),
    //         ],
    //       )),
    // );
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: AgentDrawer(),
          appBar: AppBar(
            actions: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Reference ID :",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  Text(
                    agentid,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.copy, color: Colors.white),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: agentid));
                    showToast("References copied");
                  })
            ],
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white54,
                ),
                height: 50,
                width: double.infinity,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                      color: accentClr,
                      borderRadius: BorderRadius.circular(15)),
                  indicatorWeight: 5,
                  labelStyle: font(14, Colors.black, FontWeight.w600),
                  unselectedLabelStyle:
                      font(12, Colors.white54, FontWeight.w400),
                  tabs: [
                    Text("All Customers"),
                    Text("Next Payment"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Agenthomescreen(),
                  Agentnextpaymentcustomer(),
                ]),
              )
            ],
          ),
        ));
  }
}
