import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/newBottomDrawer.dart';
import 'package:aradhana/model/Paymentdetailsmodel.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/service/Paymentdetailsserivce.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';

class Wallet extends StatefulWidget {
  static String routeName = "/Wallet";
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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

  int role;
  //String number="";
  Sheduledmodel data;
  final amountController = TextEditingController();
  getrole() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };
    role = await getSavedObject("roleid");
    try {
      EasyLoading.show(status: 'Loading...');

      Sheduledmodel datas = await Sheduledservice.postService(details);
      setState(() {
        data = datas;
      });
    } catch (e) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      print(e);
    }
    setState(() {
      role;
    });
    print(role);
  }

  @override
  void initState() {
    getrole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: role == 2 || role == 4
            ? Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.sort, size: 30),
                      onPressed: () {
                        newDrawerr(
                            context, data.data.termsandcondtion.description);
                        // NewBottomSheet();
                        // Scaffold.of(context).openDrawer();
                      }),
                ),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
        centerTitle: true,
        title: Image.asset("assets/logoOnly.png", height: 40),
        actions: [
          role == 2 || role == 4
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Notifications.routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Stack(
                          children: [
                            Container(
                              child: Icon(Icons.notifications, size: 30),
                            ),
                            data.data.notificationCount == 0
                                ? Container()
                                : Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 0),
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffc32c37),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Center(
                                          child: Text(
                                            data.data.notificationCount
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<Paymentdetailsmodel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data.paymentsList.length == 0) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/fixedAssets/emptyWallet.json',
                        repeat: false,
                        height: MediaQuery.of(context).size.height * 0.4),
                    Text(
                      "No transaction history available,\nMake your first payment.",
                      textAlign: TextAlign.center,
                      style: font(15, Colors.black54, FontWeight.w500),
                    ),
                  ],
                )),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: goldenUpDownGradient,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "WALLET BALANCE",
                                        style: size14_700,
                                      ),
                                      Text(
                                          rs +
                                              snapshot.data.data.sumAmount
                                                  .toString()
                                                  .split(".")[0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: VerticalDivider(
                                  color: Colors.black54,
                                )),
                                Visibility(
                                  visible: snapshot.data.data.schemeName ==
                                              "WIN AND WEAR" ||
                                          snapshot.data.data.schemeName ==
                                              "MY GOLD"
                                      ? false
                                      : true,
                                  // visible: snapshot.data.data.subsciption.redeemType==0??"0",
                                  child: Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total Gram".toUpperCase(),
                                            style: size14_700),
                                        Text(snapshot.data.data.sumGram,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  h(15),
                  div,
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, bottom: 15, left: 20),
                    child: Text("HISTORY", style: smallHeading),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Scrollbar(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.paymentsList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10, right: 10),
                                child: Container(
                                    // height: 110,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(colorArr[
                                          int.parse(randomNumeric(1))]),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (index == 0)
                                            Row(
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data.data.schemeName
                                                        .toString(),
                                                    style: size12_600),
                                                Spacer(),
                                                Text(
                                                    DateFormat("dd-MMM-yyyy")
                                                        .format(snapshot.data
                                                            .data.paymentsList
                                                            .elementAt(index)
                                                            .paymentDate),
                                                    style: font(
                                                        12,
                                                        Colors.black54,
                                                        FontWeight.w600))
                                                // Spacer(),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           bottom: 0),
                                                //   child: Text(
                                                //     DateFormat("dd-MM-yyyy")
                                                //         .format(snapshot.data
                                                //             .data.paymentsList
                                                //             .elementAt(index)
                                                //             .paymentDate),
                                                //     style: TextStyle(
                                                //         fontWeight:
                                                //             FontWeight.w500,
                                                //         color: Colors.black),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          h(5),
                                          Visibility(
                                            visible: true,
                                            //   visible: snapshot.data.data.subsciption.redeemType==0,
                                            child: Row(
                                              children: [
                                                snapshot.data.data.schemeName ==
                                                            "WIN AND WEAR" ||
                                                        snapshot.data.data
                                                                .schemeName ==
                                                            "MY GOLD"
                                                    ? Opacity(opacity: 0)
                                                    : Text(
                                                        "Weight :  " +
                                                            snapshot.data.data
                                                                .paymentsList
                                                                .elementAt(
                                                                    index)
                                                                .gram +
                                                            "  Gram",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.black)),
                                                Spacer(),
                                                if (index != 0)
                                                  Text(
                                                      DateFormat("dd-MMM-yyyy")
                                                          .format(snapshot.data
                                                              .data.paymentsList
                                                              .elementAt(index)
                                                              .paymentDate),
                                                      style: font(
                                                          12,
                                                          Colors.black54,
                                                          FontWeight.w600))
                                              ],
                                            ),
                                          ),
                                          h(5),
                                          Visibility(
                                            visible: true,
                                            child: Text(
                                                "Amount :  " +
                                                    rs +
                                                    snapshot
                                                        .data.data.paymentsList
                                                        .elementAt(index)
                                                        .amount
                                                        .toString()
                                                        .split(".")[0],
                                                style: font(13, Colors.black,
                                                    FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return Container();
          }
        },
        future: getPaymentdetails(),
      ),
    );
  }

  Future<Paymentdetailsmodel> getPaymentdetails() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };
    Paymentdetailsmodel datas;
    print(details);
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      datas = await Paymentdetailsservice.postService(details);
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

  NewBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Stack(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              "Enter Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      ),
                    ),
                    TextField(
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      // controller:_phoneNumberController ,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 10),
                    ),
                  ],
                ),
              ),
            ]));
  }
}
