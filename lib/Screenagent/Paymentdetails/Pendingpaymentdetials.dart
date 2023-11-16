import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/model/Agentpendingmodel.dart';
import 'package:aradhana/service/Pendingpaymentservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class PendingPayment extends StatefulWidget {
  static String routeName = "/PendingPayment";
  @override
  _PendingPaymentState createState() => _PendingPaymentState();
}

class _PendingPaymentState extends State<PendingPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Pending Amount", style: appBarTxtStyl),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: ListView(
        children: [
          FutureBuilder(
            builder: (context, AsyncSnapshot<Agentpendingmodel> snapshot) {
              if (snapshot.hasData) {
                {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: HexColor("#D4EDDA"),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              "AMOUNT",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                              rs +
                                                  snapshot.data.data.pending
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25)),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          //   Padding(
                                          //   padding: const EdgeInsets.only(bottom: 5),
                                          //   child: Text("Balance",style: TextStyle(fontWeight: FontWeight.w500,color: HexColor("#643036")),),
                                          // ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       bottom: 15, right: 3),
                                              //   child: Container(
                                              //       child: Image.asset(
                                              //     "assets/goldcoin.png",
                                              //     fit: BoxFit.fill,
                                              //   )),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                          h(10),
                          div,
                          h(10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("COLLECTION LIST", style: smallHeading),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.adminpayment.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return (snapshot
                                            .data.data.adminpayment.length ==
                                        0)
                                    ? Center(
                                        child: Text(
                                        "No data",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    : Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color: HexColor("#EDFCBA"),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15,
                                              top: 20,
                                              bottom: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0.0),
                                                child: Text(
                                                  "From date : " +
                                                      snapshot.data.data
                                                          .adminpayment
                                                          .elementAt(index)
                                                          .fromdate
                                                          .toString()
                                                          .substring(0, 10),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor("#643036"),
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Text(
                                                  "To date : " +
                                                      snapshot.data.data
                                                          .adminpayment
                                                          .elementAt(index)
                                                          .todate
                                                          .toString()
                                                          .substring(0, 10),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor("#643036")),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Text(
                                                  "Amount : " +
                                                      snapshot.data.data
                                                          .adminpayment
                                                          .elementAt(index)
                                                          .pendingamount
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor("#643036")),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.only(bottom: 15),
                                              //   child: Row(
                                              //     children: [
                                              //       Text(snapshot.data.data.paymentsList.elementAt(index).gram,
                                              //           style: TextStyle(
                                              //               fontWeight: FontWeight.w600,
                                              //               fontSize: 18,
                                              //               color:
                                              //                   HexColor("#643036"))),
                                              //       Padding(
                                              //         padding: const EdgeInsets.only(
                                              //             left: 8.0),
                                              //         child: Text("Gram",
                                              //             style: TextStyle(
                                              //                 fontWeight:
                                              //                     FontWeight.w400,
                                              //                 fontSize: 13,
                                              //                 color:
                                              //                     HexColor("#643036"))),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ));
                              }),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return Container();
              }
            },
            future: getPaymentdetails(),
          ),
        ],
      ),
    );
  }

  Future<Agentpendingmodel> getPaymentdetails() async {
    Agentpendingmodel datas;
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      datas = await Pendingpaymentservice.getpendingpayment();
      print("Reached here");
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();
      //  totalpayment = data.data.sheduledList.length;
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      return datas;
      //  Navigator.pop(context);
    }
  }
}
