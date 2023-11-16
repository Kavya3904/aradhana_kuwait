import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../Constants/Constants.dart';

class UpcomingPaymentList extends StatelessWidget {
  static String routeName = "/UpcomingPaymentList";

  const UpcomingPaymentList({Key key}) : super(key: key);
  // "tittle": "Payment History",
  //                 "list": widget.data.data.paidPayment,
  //                 "containerColor": "F8D7DA",
  //                 "textColor": "155724"

  @override
  Widget build(BuildContext context) {
    Map details = ModalRoute.of(context).settings.arguments;
    Sheduledmodel data = details["list"];

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
          title: Text("Upcoming Payment", style: appBarTxtStyl)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            if (data.data.upcomingPayment.length != 0)
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.data.upcomingPayment.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return data.data.schemetype == 1
                          ? Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: HexColor("#FFF3CD"),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 15, top: 15),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  child: Text(
                                                rs +
                                                    data.data.monthlyAmont
                                                        .toString()
                                                        .split(".")[0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor("#856404"),
                                                    fontSize: 15),
                                              )),
                                              Center(
                                                  child: Text("  to ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              "#856404"),
                                                          fontSize: 15))),
                                              Text(
                                                rs +
                                                    data.data.amountTo
                                                        .toString()
                                                        .split(".")[0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor("#856404"),
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Due Date  : " +
                                                  DateFormat("dd-MMM-yyyy")
                                                      .format(DateTime.now())
                                                      .toString()
                                                      .substring(0, 10),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#856404")),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data.data.paymentType == 0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Container(
                                                decoration: BoxDecoration(

                                                    //                   border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0),
                                                    child: Text(
                                                      rs +
                                                          data.data
                                                              .monthlyAmont,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              "#856404"),
                                                          fontSize: 18),
                                                    ))))
                                        : Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    rs +
                                                        data.data.monthlyAmont
                                                            .toString()
                                                            .split(".")[0],
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#856404"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  )),
                                              Text(
                                                " to " +
                                                    rs +
                                                    data.data.amountTo
                                                        .toString()
                                                        .toString()
                                                        .split(".")[0],
                                                style: TextStyle(
                                                    color: HexColor(
                                                      "#856404",
                                                    ),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: data.data.schemetype != 1
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Date : " +
                                                      DateFormat("dd-MMM-yyyy")
                                                          .format(data.data
                                                              .upcomingPayment
                                                              .elementAt(index)
                                                              .paymentStartDates),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          HexColor("#856404")),
                                                ),
                                                Text(
                                                  "  to " +
                                                      DateFormat("dd-MMM-yyyy")
                                                          .format(data.data
                                                              .upcomingPayment
                                                              .elementAt(index)
                                                              .paymentEndDates),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          HexColor("#856404")),
                                                ),
                                              ],
                                            )
                                          : Container(
                                              child: Text("Start Date : " +
                                                  new DateTime.now()
                                                      .toString()
                                                      .substring(0, 10)),
                                            )
                                      // Column(children: [
                                      //         Text("Start Date : " +
                                      //  new DateTime.now().toString()
                                      //                 ),
                                      // ],)
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
