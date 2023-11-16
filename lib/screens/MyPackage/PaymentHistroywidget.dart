import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/model/paymentmodel.dart';
import 'package:aradhana/screens/Paymentsendscreen/Paymentscreen.dart';
import 'package:aradhana/service/Paymentservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class PaymentHistroywidget extends StatefulWidget {
  final Sheduledmodel data;
  final dynamic paymentpendingid;
  final dynamic paymentdate;
  final dynamic schemeId;
  final dynamic schemeAmountId;
  final dynamic paymentStartDates;
  final dynamic paymentEndDates;
  final bool vis;
  final String upistatus;
  final Function paymentrefresh;

  const PaymentHistroywidget({
    Key key,
    this.data,
    this.paymentpendingid,
    this.paymentdate,
    this.schemeId,
    this.schemeAmountId,
    this.paymentStartDates,
    this.paymentEndDates,
    this.upistatus,
    this.vis,
    this.paymentrefresh,
  }) : super(key: key);

  @override
  _PaymentHistroywidgetState createState() => _PaymentHistroywidgetState();
}

class _PaymentHistroywidgetState extends State<PaymentHistroywidget> {
  final amountController = TextEditingController();
  bool ios = true;
  getdata() async {
    int z = await getSavedObject('userid');

    bool b = z == iosUser ? false : true;
    print(b);
    setState(() {
      ios = b;
      print(ios);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
////////////////////////////////////////////////////

/////////////////////////////////////////////

            widget.vis
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
                    child: Text("PENDING PAYMENT",
                        style: TextStyle(color: Colors.black)),
                  )
                : Container(),
            widget.vis
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#F8D7DA"),
                          border: Border.all(
                            width: 1.5,
                            color: HexColor("#F5C6CB"),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 15, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.data.data.paymentType == 0
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6,
                                              right: 6,
                                              top: 2,
                                              bottom: 2),
                                          child: Text(
                                              "₹ " +
                                                  widget.data.data.monthlyAmont
                                                      .toString(),
                                              style: TextStyle(
                                                  color: HexColor("#EE4E4E"),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17)),
                                        )),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0),
                                                child: Text(
                                                  "Rs. " +
                                                      widget.data.data
                                                          .monthlyAmont,
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              )),
                                            ),
                                            Center(
                                                child: Text(
                                              " to ",
                                              style: TextStyle(
                                                  color: HexColor("#721C24"),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0),
                                                child: Text(
                                                  widget.data.data.amountTo,
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#721C24"),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Start Date : " +
                                              DateFormat("dd-MM-yyyy").format(
                                                widget.paymentStartDates,
                                              ),
                                          style: TextStyle(
                                              color: HexColor("#721C24"),
                                              fontSize: 13)),
                                      Text(
                                          "End Date   : " +
                                              DateFormat("dd-MM-yyyy").format(
                                                  widget.paymentEndDates),
                                          style: TextStyle(
                                              color: HexColor("#721C24"),
                                              fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                if (await getSavedObject("roleid") == 2 ||
                                    await getSavedObject("roleid") == 4) {
                                  Map details = {
                                    'type': widget.data.data.paymentType,
                                    'UserId': await getSavedObject('userid'),
                                    'toamount': widget.data.data.amountTo,
                                    'SheduledDateId': widget.paymentpendingid,
                                    'gram': widget.data.data.todayEarnings
                                        .toString(),
                                    'amount': widget.data.data.monthlyAmont,
                                    'taransactionId': "nill",
                                    'subscriptionId':
                                        await getSavedObject('subscription'),
                                    'paidBy': await getSavedObject('userid'),
                                    'todaysrate': widget.data.data.todayRate
                                  };

                                  // Navigator.pushNamed(context,
                                  //         Razorpayui.routeName)
                                  //     .then((value)
                                  //     {
                                  //   getProfile();
                                  // });
                                  if (widget.upistatus.compareTo("0") == 0) {
                                    Navigator.pushNamed(
                                            context, Paymentscreen.routeName,
                                            arguments: details)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  } else {
                                    showToast(
                                        "You have already made a payment waiting for approval");
                                  }
                                } else if (await getSavedObject("roleid") ==
                                    3) {
                                  //  if(sendConfirmation())

                                  widget.data.data.paymentType == 0
                                      ? showAlertDialog(context)
                                      : showAlertDialogvarient(context);
                                }
                              },

// for ios
                              child: Visibility(
                                visible: ios,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: HexColor("#F5C6CB"),
                                      // Set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              100.0)), // Set rounded corner radius
                                      // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        "PAY",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor("#720755"),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 10.0, top: 20, bottom: 10),
              child: Text(
                "UPCOMING PAYMENT",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.data.data.sheduledList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return widget.data.data.sheduledList
                              .elementAt(index)
                              .status ==
                          0
                      ? Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: HexColor("#FFF3CD"),
                              border: Border.all(
                                width: 1.5,
                                color: HexColor("#FFF3CD"),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25, top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.data.data.paymentType == 0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Container(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 6,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: Text(
                                                    "Rs. " +
                                                        widget.data.data
                                                            .monthlyAmont,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            HexColor("#856404"),
                                                        fontSize: 18),
                                                  ))))
                                      : Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, bottom: 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: Text(
                                                        "Rs. " +
                                                            widget.data.data
                                                                .monthlyAmont,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: HexColor(
                                                                "#856404"),
                                                            fontSize: 15),
                                                      )),
                                                )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0, top: 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: Text(
                                                        " to " +
                                                            widget.data.data
                                                                .amountTo
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#856404"),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      )),
                                                )),
                                          ],
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start Date : " +
                                              DateFormat("dd-MM-yyyy").format(
                                                  widget.data.data.sheduledList
                                                      .elementAt(index)
                                                      .paymentStartDates),
                                          style: TextStyle(
                                              color: HexColor("#856404"),
                                              fontSize: 13),
                                        ),
                                        Text(
                                            "End Date   : " +
                                                DateFormat("dd-MM-yyyy").format(
                                                    widget
                                                        .data.data.sheduledList
                                                        .elementAt(index)
                                                        .paymentEndDates),
                                            style: TextStyle(
                                                color: HexColor("#856404"),
                                                fontSize: 13)),
                                      ],
                                    ),
                                  ),
                                ],
                              )))
                      : Container();
                })
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        agentpay(widget.data.data.monthlyAmont,
            widget.data.data.todayEarnings.toString());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment"),
      content: Text("Would you like to continue with the paymnet?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogvarient(BuildContext context) {
    double gram = 0;
    String finalgram = "";
    // amountController.addListener(() {
    //   if (amountController.text.toString().isNotEmpty)
    //     setState(() {
    //       gram = double.parse(amountController.text.toString());
    //     });
    // });

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        amountController.text = "";
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed: () {
          try {
            if ((double.parse(amountController.text.toString()) <=
                    double.parse(widget.data.data.amountTo.toString())) &&
                (double.parse(amountController.text.toString()) >=
                    double.parse(widget.data.data.monthlyAmont.toString()))) {
              Navigator.pop(context);
              agentpay(amountController.text.toString(), finalgram);
            } else {
              showToast("Please enter amount with in range");
            }
          } catch (e) {
            showToast("Please enter amount with in range");
          }
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment"),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please enter the amount to pay ?"),
              Center(
                child: Container(
                    width: 150,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter amount",
                        counterText: "",
                      ),
                      controller: amountController,
                      maxLength: 8,
                      onChanged: (value) {
                        setState(() {
                          print(value + "test");
                          if (value.isEmpty) {
                            gram = 0;
                            finalgram = "";
                          } else {
                            gram = double.parse(value) /
                                double.parse(
                                    widget.data.data.todayRate.toString());

                            finalgram = gram.toStringAsFixed(3);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              // Text("Gold in gram :" + finalgram),
            ],
          ),
        );
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void agentpay(String amount, String gram) async {
    print(gram);
    print(amount);
    Map details = {
      'UserId': await getSavedObject('customerid'),
      'SheduledDateId': widget.paymentpendingid,
      'gram': gram,
      'amount': amount,
      'taransactionId': "nil",
      'subscriptionId': await getSavedObject('subscription'),
      'paidBy': await getSavedObject('userid')
    };
    print(details);
    try {
      EasyLoading.show(status: 'Loading...');
      Paymentmodel datas = await Paymentservice.postPay(details);
      print("Reached here");

      EasyLoading.dismiss();
      widget.paymentrefresh();
      // getProfile();
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
  }
}
