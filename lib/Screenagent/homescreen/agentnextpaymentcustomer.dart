import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Nextpaymentcustomerlistmodel.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/service/customerlistservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:random_string/random_string.dart';

class Agentnextpaymentcustomer extends StatefulWidget {
  const Agentnextpaymentcustomer({
    Key key,
  }) : super(key: key);
  @override
  _AgentnextpaymentcustomerState createState() =>
      _AgentnextpaymentcustomerState();
}

class _AgentnextpaymentcustomerState extends State<Agentnextpaymentcustomer> {
  int subid;
  List<int> subidlist = new List();
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
  StreamController<List<CustomerList>> _dataStream;
  Stream broadcastStream;
  List<CustomerList> customerListall;
  List<CustomerList> customerListsearch = new List();
  // Agentcustomermodel data = new Agentcustomermodel();
  @override
  void initState() {
    _dataStream = StreamController<List<CustomerList>>();
    broadcastStream = _dataStream.stream.asBroadcastStream();
    getCustomerlistnextpayment();
    super.initState();
  }

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
          print("hai");
          print(customerListsearch.length.toString());
          print("hai");
          customerListsearch.add(element);
        }
      });

      _dataStream.add(customerListsearch);
    }
  }

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
                color: Color.fromRGBO(255, 255, 255, .24),
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 250,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white,
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
                                            await saveObject(
                                                "subscription",
                                                snapshot.data
                                                    .elementAt(index)
                                                    .subscriptionId);

                                            Navigator.pushNamed(
                                                context, HomeTabs.routeName);
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
                                                        Icon(Icons.phone,
                                                            size: 16),
                                                        Text(
                                                          "  " +
                                                              snapshot.data
                                                                  .elementAt(
                                                                      index)
                                                                  .phone
                                                                  .toString(),
                                                          style: size14_400,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
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

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 20.0, bottom: 15),
      //   child: Container(
      //     width: 64,
      //     height: 64,
      //     child: FloatingActionButton(
      //         onPressed: () {
      //           {
      //             var b =
      //                 Navigator.pushNamed(context, Agenstregistration.routeName)
      //                     .then((value) => widget.fun());

      //             //    if (b != null) {

      //             //  }

      //           }
      //         },
      //         child: const Icon(
      //           Icons.add,
      //           size: 30,
      //         ),
      //         backgroundColor: HexColor("#FFCD5E")),
      //   ),
      // ),
    );
  }

  getCustomerlistnextpayment() async {
    Nextpaymentcustomerlistmodel datas;
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      datas = await Customerlistservice.getCustomernextpaymnetlist();
      EasyLoading.dismiss();
      //  Navigator.of(context).pop(true);
      // showLoading(context);

      //  customerList = datas.data.customerList;
      customerListall = datas.data.customerList;
      EasyLoading.dismiss();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      _dataStream.add(customerListall);

      //    _dataStream.add(datas);
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //   return datas;
      //  Navigator.pop(context);
    }
  }
}
