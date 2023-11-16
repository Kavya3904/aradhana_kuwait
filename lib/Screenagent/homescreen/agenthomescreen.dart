import 'dart:async';
import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/Agentregistration/Agenstregistration.dart';
import 'package:aradhana/Screenagent/Customerplans/Customerschemedetails.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/agentlistmodel.dart';
import 'package:aradhana/service/customerlistservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info/package_info.dart';
import 'package:random_string/random_string.dart';

class Agenthomescreen extends StatefulWidget {
  static String routeName = "/Agenthomescreen";
  // final Agentcustomermodel data;
  // final Function fun;

  // const Agenthomescreen({Key key, this.data, this.fun}) : super(key: key);

  @override
  _AgenthomescreenState createState() => _AgenthomescreenState();
}

class _AgenthomescreenState extends State<Agenthomescreen> {
  int subid;
  List<int> subidlist = new List();
  // Agentcustomermodel data = new Agentcustomermodel();
  StreamController<List<CustomerList>> _dataStream;
  Stream broadcastStream;
  List<CustomerList> customerListall;
  List<CustomerList> customerListsearch = new List();

  @override
  void initState() {
    super.initState();
    getCustomerlist();
    _dataStream = StreamController<List<CustomerList>>();
    broadcastStream = _dataStream.stream.asBroadcastStream();
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
  search(String text) {
    print(text);
    if (text.isEmpty) {
      _dataStream.add(customerListall);
    } else {
      customerListsearch.clear();
      customerListall.forEach((element) {
        if (element.name.toLowerCase().contains(text.toLowerCase()) ||
            element.registrationNumber
                .toLowerCase()
                .contains(text.toLowerCase())) {
          print(customerListsearch.length.toString());

          customerListsearch.add(element);
        }
      });

      _dataStream.add(customerListsearch);
    }
  }

  String id;
  TextEditingController controllers = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 20, right: 20, bottom: 10),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                boxShadow: [shadow],
                border: Border.all(color: Colors.black12),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(),
                    child: TextField(
                      cursorColor: Colors.black54,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      controller: controllers,
                      onChanged: search,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: "OpenSans"),
                          border: InputBorder.none,
                          hintText: 'Search'),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    color: Colors.black87,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: broadcastStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: snapshot.data != null
                      ? Expanded(
                          child: snapshot.data.length == 0
                              ? Center(
                                  child: Text("No Clients",
                                      style: TextStyle(color: Colors.black)),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20, top: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [shadow],
                                            border: Border.all(
                                                color: Colors.black12),
                                            color: Color(colorArr[
                                                int.parse(randomNumeric(1))]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: InkWell(
                                          onTap: () async {
                                            await saveObject(
                                                "customerid",
                                                snapshot.data
                                                    .elementAt(index)
                                                    .userId);

                                            Navigator.pushNamed(
                                                context,
                                                Customerschemedetails
                                                    .routeName);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    snapshot.data
                                                        .elementAt(index)
                                                        .registrationNumber
                                                        .toString(),
                                                    style: size16_600),
                                                h(5),
                                                Row(
                                                  children: [
                                                    Icon(Icons.person,
                                                        size: 16),
                                                    Text(
                                                        "  " +
                                                            snapshot.data
                                                                .elementAt(
                                                                    index)
                                                                .name
                                                                .toString(),
                                                        style: size14_700),
                                                  ],
                                                ),
                                                h(5),
                                                Row(
                                                  children: [
                                                    Icon(Icons.phone, size: 16),
                                                    Text(
                                                      "  " +
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .phone
                                                              .toString(),
                                                      style: size14_400,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        )
                      : Center(child: Text("No Data", style: size15_800W)),
                );
              } else {
                return Container(color: bgClr);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var b = Navigator.pushNamed(context, Agenstregistration.routeName)
              .then((value) => getCustomerlist());
        },
        label: Text('New Customer', style: size14_700),
        icon: const Icon(Icons.add, color: Colors.black),
        backgroundColor: accentClr,
      ),
    );
  }

  Future<void> getCustomerlist() async {
    Agentcustomermodel datas;
    List<CustomerList> customerList;

    String buildNumber = "11";
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      datas = await Customerlistservice.getCustomerlist();
      customerList = datas.data.customerList;
      customerListall = datas.data.customerList;
      EasyLoading.dismiss();
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        buildNumber = packageInfo.buildNumber;
        print(buildNumber);

        ///   print(packageInfo.version);
        ///
        ///
        ///  remove this code after 12

        if (Platform.isAndroid) {
          if (datas.data.versions.android > int.parse(buildNumber)) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Update', (Route<dynamic> route) => false);
          }
          // Android-specific code
        } else if (Platform.isIOS) {
          if (datas.data.versions.ios > int.parse(buildNumber)) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Update', (Route<dynamic> route) => false);
          }
          // iOS-specific code
        }
      });

      //  Navigator.of(context).pop(true);
      // showLoading(context);
      _dataStream.add(customerList);
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      String number = await getSavedObject("phone");
      String token = await getSavedObject("token");
      print(number);
      print(token);

      //   return datas;
      //  Navigator.pop(context);
    }
  }
}
