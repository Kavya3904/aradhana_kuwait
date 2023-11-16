import 'package:aradhana/screens/Recepit/Recepit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../Constants/Constants.dart';

class ListViews extends StatelessWidget {
  static String routeName = "/ListView";

  const ListViews({Key key}) : super(key: key);
  // "tittle": "Payment History",
  //                 "list": widget.data.data.paidPayment,
  //                 "containerColor": "F8D7DA",
  //                 "textColor": "155724"

  @override
  Widget build(BuildContext context) {
    Map details = ModalRoute.of(context).settings.arguments;
    List<dynamic> listData = details["list"];
    Color containerColor = HexColor(details["containerColor"]);
    Color textColor = HexColor(details["textColor"]);
    dynamic schemetype = (details["schemeType"]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title: Text(details["tittle"], style: appBarTxtStyl),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 10),
        child: Scrollbar(
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: listData.length,
              itemBuilder: (BuildContext ctxt, int index) {
                Color containerColor;
                Color textColor;

//                   if (widget.data.data.sheduledList.elementAt(index).status ==
//                       3) {
// // not paid
//                     containerColor = HexColor("#F8D7DA");
//                     textColor = HexColor("#721C24");

//                   }

//                   if (widget.data.data.sheduledList.elementAt(index).status ==
//                       1) {
// // on going
//                     containerColor = HexColor("#F8D7DA");
//                     textColor = HexColor("#721C24");
//                   }

//                   if (widget.data.data.sheduledList.elementAt(index).status ==
//                       0) {
// // upcoming

//                     containerColor = HexColor("#FFF3CD");
//                     textColor = HexColor("#856404");
//                   }

                //   if (widget.data.data.sheduledList.elementAt(index).status ==
                //        2) {
                containerColor = HexColor("#D4EDDA");
                textColor = HexColor("#155724");
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: paymentItem(
                      listData: listData,
                      textColor: textColor,
                      containerColor: containerColor,
                      index: index,
                      shcemeType: schemetype,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class paymentItem extends StatelessWidget {
  const paymentItem(
      {Key key,
      @required this.listData,
      @required this.textColor,
      @required this.containerColor,
      @required this.index,
      @required this.shcemeType})
      : super(key: key);

  final List<dynamic> listData;
  final Color textColor;
  final int index;
  final Color containerColor;
  final dynamic shcemeType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (shcemeType != 1)
              Text(
                "Date :" +
                    DateFormat("dd, MMM-yyyy")
                        .format(listData.elementAt(index).paymentStartDates) +
                    " to " +
                    DateFormat("dd, MMM-yyyy")
                        .format(listData.elementAt(index).paymentEndDates),
                style: TextStyle(fontSize: 12, color: textColor),
              ),
            if (shcemeType == 1)
              Text(
                  "Date :" +
                      DateFormat("dd, MMM-yyyy")
                          .format(listData.elementAt(index).updatedAt),
                  style: TextStyle(fontSize: 12, color: textColor)),
            if (listData.elementAt(index).status == 2)
              if (listData.elementAt(index).status == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.done, color: textColor),
                    SizedBox(width: 5),
                    Text(
                      "PAID",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 2, bottom: 2),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: listData.elementAt(index).status == 2,
                                child: InkWell(
                                  onTap: (() {
                                    Navigator.pushNamed(
                                        context, Recepit.routeName,
                                        arguments:
                                            listData.elementAt(index).id);
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: HexColor("#C5DECB"),
                                      boxShadow: [shadow],
                                      border: Border.all(color: Colors.black12),
                                      // Set border width

                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "Receipt",
                                          style: TextStyle(color: textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
