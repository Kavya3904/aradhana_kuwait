import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Bankdetailsmodel.dart';
import 'package:aradhana/model/userpaymodel.dart';
import 'package:aradhana/screens/Paymentsendscreen/newWidgetsPaymentPage.dart';
import 'package:aradhana/service/Paymentservice.dart';
import 'package:aradhana/service/bankdetailsservice.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class Paymentscreen extends StatefulWidget {
  static String routeName = "/Paymentscreen";
  @override
  _PaymentscreenState createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  bool sentTap = false;

  //THEME--------------------------------------
  bool darkmode = true;
  final bg = Color(0xff261d1d);
  //THEME--------------------------------------

  Future exitt() {
    Navigator.pop(context);
  }
// UserId:50
// SheduledDateId:316
// gram:2
// amount:1000
// taransactionId:1
// subscriptionId:29
// paidBy:21
//
// 'type':data.data.paymentType,
  //    'UserId': await getSavedObject('userid'),
  //  'toamount':  data.data.amountTo,
  //     'SheduledDateId': paymentpendingid,
  //     'gram':  data.data.todayEarnings.toString(),
  //     'amount': data.data.monthlyAmont,
  //     'taransactionId': "12345678",
  //     'subscriptionId': await getSavedObject('subscription'),
  //     'paidBy': await getSavedObject('userid'),
  //     'todaysrate':data.data.todayRate

  TextEditingController amountController = TextEditingController();
  TextEditingController transidController = TextEditingController();
  String finalgram = "";
  Map details;
  double gram = 0;
  File _image;
  final picker = ImagePicker();
  int paymentmethod = 1;
  String schemetype;
  String average;
  String currentstatus;
  Bankdetailsmodel bankdDetails = new Bankdetailsmodel();

//////paytm
  String payment_response;

  //Live
  // String mid = "LIVE_MID_HERE";
  // String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
  // String website = "DEFAULT";
  // bool testing = false;

  //Testing
  String mid = "PmyQlW65879937951416";
  String PAYTM_MERCHANT_KEY = "uGOzDNCI7dFq8E!d";
  String website = "WEBSTAGING";
  bool testing = true;
  bool isUpiPresent = true;
  bool isbankdetailsPresent = true;
  int tablength = 0;

  double amount = 1;
  bool loading = false;
  int selectedRadio;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      paymentmethod = val;
    });
  }

  Future getImage(setState) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {});
      } else {
        print('No image selected.');
      }
    });
  }

  int _selectedTabbar = 0;
  bool isLoading = false;
  List upi = [];
  List bank = [];

  var upiID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBankDetails();
    Future.delayed(Duration.zero, () {
      setState(() {
        details = ModalRoute.of(context).settings.arguments;
        amountController.text = details['type'].toString() == "0"
            ? details['amount'].toString()
            : "";

        schemetype = details['schemetype'];
        average = details['average'];
        currentstatus = details['currentstatus'];
      });
    });
    selectedRadio = 0;
  }

  Future<void> getBankDetails() async {
    try {
      EasyLoading.show(status: 'Loading...');
      isLoading = true;
      //    showLoading(context);
      Bankdetailsmodel bankdetails = await Branchdetailservice.getBankDetails();
      setState(() {
        bankdDetails = bankdetails;
      });
      print(bankdetails);
      isbankdetailsPresent =
          bankdDetails.data.bankDetails.isEmpty ? false : true;

      isUpiPresent = bankdDetails.data.upiDetails.isEmpty ? false : true;

      for (var i = 0; i < bankdDetails.data.upiDetails.length; i++) {
        var newupi = {'upiId': bankdDetails.data.upiDetails.elementAt(i).upiId};
        upi.add(newupi);
      }

      //`````````````bankkk```````````````````

      for (var i = 0; i < bankdDetails.data.bankDetails.length; i++) {
        var beniName =
            bankdDetails.data.bankDetails.elementAt(i).beneficiaryName;
        var accNo = bankdDetails.data.bankDetails.elementAt(i).accNo;
        var ifsc = bankdDetails.data.bankDetails.elementAt(i).ifscCode;
        var bankName = bankdDetails.data.bankDetails.elementAt(i).bankName;
      }

      if (isbankdetailsPresent && isUpiPresent) {
        tablength = 2;
      } else {
        tablength = 1;
      }

      EasyLoading.dismiss();
      setState(() {
        isLoading = false;
      });

      EasyLoading.dismiss();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      // setState(() {
      //   EasyLoading.dismiss();
      //   data = datas;
      //   print(data);
      //   //  test();
      // });
    } catch (e) {
      isLoading = true;
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Scaffold(
            extendBody: true,
            backgroundColor: darkmode == true ? bg : Colors.white,
            appBar: AppBar(
              backgroundColor: bg,
              title: Text(
                "Payment Details",
                style: size(15),
              ),
            ),
            body: details == null
                ? Container()
                : ListView(
                    children: [
                      h(20),
                      FittedBox(
                        child: Text(
                          "Send money through Bank or UPI ID and send the screenshot",
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                darkmode == true ? Colors.white : Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      h(15),
                      Row(
                        children: [
                          w(10),
                          Image.asset("assets/fixedAssets/upi.png", height: 15),
                          w(10),
                          Text(
                            "UPI ID DETAILS",
                            style: TextStyle(
                              fontSize: 13,
                              color: darkmode == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                      h(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PaymentButtons("assets/fixedAssets/gpay.png",
                              "Google Pay", Colors.white, () {
                            upiAlertImg("assets/fixedAssets/gpayLogo.png",
                                () async {
                              showToastCenter("Copied");
                              await LaunchApp.openApp(
                                  androidPackageName:
                                      'com.google.android.apps.nbu.paisa.user',
                                  iosUrlScheme: 'gpay://',
                                  appStoreLink:
                                      'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                                  openStore: false);
                            });
                          }, darkmode),
                          PaymentButtons("assets/fixedAssets/phonepe.png",
                              "PhonePe", Color(0xff5f259f), () {
                            upiAlertImg("assets/fixedAssets/phonepeLogo.png",
                                () async {
                              await LaunchApp.openApp(
                                  androidPackageName: 'com.phonepe.app',
                                  iosUrlScheme: 'phonepe://',
                                  appStoreLink:
                                      'https://apps.apple.com/in/app/phonepe-secure-payments-app/id1170055821',
                                  openStore: false);
                            });
                          }, darkmode),
                          PaymentButtons("assets/fixedAssets/paytm.png",
                              "Paytm", Colors.white, () {
                            upiAlertImg("assets/fixedAssets/paytmLogo.png",
                                () async {
                              showToastCenter("Upi id copied");
                              await LaunchApp.openApp(
                                  androidPackageName: 'net.one97.paytm',
                                  iosUrlScheme: 'paytm://',
                                  appStoreLink:
                                      'https://apps.apple.com/in/app/paytm-secure-upi-payments/id473941634',
                                  openStore: false);
                            });
                          }, darkmode),
                        ],
                      ),
                      h(10),
                      Divider(
                          color: darkmode == true
                              ? Colors.grey[800]
                              : Colors.grey[300],
                          thickness: 8),
                      h(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.landmark,
                              size: 18,
                              color: darkmode == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            w(10),
                            Text(
                              "Bank Details".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: darkmode == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      h(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: SizedBox(
                          height: 250,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: bankdDetails.data.bankDetails.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white54)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          bankdDetails.data.bankDetails
                                              .elementAt(index)
                                              .bankName,
                                          style: size14_700W),
                                      h(10),
                                      copyFields(
                                          "Beneficiary Name",
                                          bankdDetails.data.bankDetails
                                              .elementAt(index)
                                              .beneficiaryName, () {
                                        Clipboard.setData(ClipboardData(
                                            text: bankdDetails.data.bankDetails
                                                .elementAt(index)
                                                .beneficiaryName));
                                        showToastCenter(
                                            "Beneficiary Name copied");
                                      }, darkmode),
                                      Divider(color: Colors.grey),
                                      copyFields(
                                          "Account Number",
                                          bankdDetails.data.bankDetails
                                              .elementAt(index)
                                              .accNo, () {
                                        Clipboard.setData(ClipboardData(
                                            text: bankdDetails.data.bankDetails
                                                .elementAt(index)
                                                .accNo));
                                        showToastCenter(
                                            "Account number copied");
                                      }, darkmode),
                                      Divider(color: Colors.grey),
                                      copyFields(
                                          "Branch IFSC Code",
                                          bankdDetails.data.bankDetails
                                              .elementAt(index)
                                              .ifscCode, () {
                                        Clipboard.setData(ClipboardData(
                                            text: bankdDetails.data.bankDetails
                                                .elementAt(index)
                                                .ifscCode));
                                        showToastCenter("Branch IFSC copied");
                                      }, darkmode),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      h(20)
                    ],
                  ),
            bottomNavigationBar: Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 3, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    // uploadAlert();
                    payBottomSheet();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: goldenUpDownGradient),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "UPLOAD SCREENSHOT",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          w(10),
                          Icon(Icons.upload, color: Colors.black, size: 18)
                        ],
                      )),
                ),
              ),
            ),
          );
  }

  void pay(String amount, String gram) async {
    // if (paymentmethod == 0) {
    //   showToastCenter("Please provide a payment method");
    // } else {
    Map sendvalues = {
      'UserId': await getSavedObject('userid'),
      'SheduledDateId': details["SheduledDateId"],
      'gram': gram,
      'amount': amount,
      'taransactionId': transidController.text.toString().compareTo("") == 0
          ? "nil"
          : transidController.text.toString(),
      'subscriptionId': await getSavedObject('subscription'),
      'paidBy': await getSavedObject('userid'),
      'payment_method': paymentmethod,
      'screenshot': _image == null ? null : _image.path
    };
    print("````````````sendvalues````````````");
    print(sendvalues);
    print("`````````````sendvalues`````````````");
    try {
      EasyLoading.show(status: 'Loading...');
      Userpaymodel datas = await Paymentservice.userpay(sendvalues);
      print("Reached here");
      EasyLoading.dismiss();
      Navigator.pop(context);
      exitt();
      setState(() {
        sentTap = false;
      });
    } catch (e) {
      setState(() {
        sentTap = false;
      });
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
    // }
  }

  void upiAlertImg(String icn, GestureTapCallback onTap) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.only(bottom: 20, top: 0),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose any one UPI ID to open", style: size12_400),
              w(5),
              Image.asset(icn, height: 30)
            ],
          )
        ],
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
            Spacer()
          ],
        ),
        content: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => h(10),
          shrinkWrap: true,
          itemCount: upi.length,
          itemBuilder: (context, index) {
            final item = upi != null ? upi[index] : null;

            return list(item, index, onTap);
          },
        ),
      ),
    );
  }

  list(var item, int index, tap) {
    return DottedBorder(
      color: Colors.black,
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      strokeWidth: 1,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(child: Text(item["upiId"].toString(), style: size12_400)),
          IconButton(
              onPressed: () async {
                tap();
                await Clipboard.setData(
                    ClipboardData(text: item["upiId"].toString()));
              },
              icon: Icon(Icons.copy))
        ],
      ),
    );
  }

  void uploadAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () {
              _image = null;
              setState(() {});
              Navigator.pop(context);
              return;
            },
            child: AlertDialog(
              // insetPadding: EdgeInsets.zero,
              actions: [
                GestureDetector(
                  onTap: () {
                    print(amountController.text.length);
                    if (details["type"] == 0) {
                      if (_image == null || amountController.text.length == 0) {
                        // if (transidController.text.toString().compareTo("") ==
                        //     0) {
                        //   showToastCenter(
                        //       "Please provide a screenshot of transaction to continue");
                        // } else {
                        //   pay(amountController.text.toString(), details['gram']);
                        // }
                        showToastCenter(
                            "Please input amount & provide a screenshot of transaction to continue");
                      } else
                        pay(amountController.text.toString(), details['gram']);
                    } else {
                      if (_image == null || amountController.text.length == 0) {
                        showToastCenter(
                            "Please input amount & provide a screenshot of transaction to continue");
                      } else {
                        if (schemetype.toString().compareTo("1") == 0) {
                          if ((double.parse(amountController.text.toString()) <=
                                  double.parse(
                                      details["toamount"].toString())) &&
                              (double.parse(amountController.text.toString()) >=
                                  double.parse(details["amount"].toString()))) {
                            if (currentstatus.toString().compareTo("dialy") ==
                                0) {
                              pay(amountController.text.toString(), finalgram);
                            }

                            if (currentstatus.toString().compareTo("dialy") !=
                                0) {
                              if (double.parse(
                                      amountController.text.toString()) <=
                                  double.parse(average.toString())) {
                                pay(amountController.text.toString(),
                                    finalgram);
                              } else {
                                showToastCenter(
                                    "Please enter amount below average");
                              }
                            }

                            // schemetype = details['schemetype'];
                            // average = details['average'];
                            // currentstatus = details['currentstatus'];

                          } else {
                            showToastCenter(
                                "Please enter amount with in range");
                          }
                        } else {
                          try {
                            if ((double.parse(
                                        amountController.text.toString()) <=
                                    double.parse(
                                        details["toamount"].toString())) &&
                                (double.parse(
                                        amountController.text.toString()) >=
                                    double.parse(
                                        details["amount"].toString()))) {
                              // Navigator.pop(context);

                              if (_image == null) {
                                if (transidController.text
                                        .toString()
                                        .compareTo("") ==
                                    0) {
                                  showToastCenter(
                                      "Please provide a Transaction id or screenshot");
                                } else {
                                  pay(amountController.text.toString(),
                                      finalgram);
                                }
                              } else {
                                pay(amountController.text.toString(),
                                    finalgram);
                              }
                            } else {
                              showToastCenter(
                                  "Please enter amount with in range");
                            }
                          } catch (e) {
                            showToastCenter(
                                "Please enter amount with in range");
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: accentClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "SEND",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              titlePadding: EdgeInsets.symmetric(vertical: 20),
              actionsPadding: EdgeInsets.only(bottom: 20),
              title: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // amountController.clear();
                        setState(() {
                          _image = null;
                        });
                      },
                      icon: Icon(Icons.close, color: Colors.black)),
                  // ToggleSwitch(
                  //   minHeight: 25,
                  //   minWidth: 98,
                  //   fontSize: 10,
                  //   initialLabelIndex: 0,
                  //   activeBgColor: [accentClr],
                  //   activeFgColor: Colors.white,
                  //   inactiveBgColor: Colors.grey[200],
                  //   inactiveFgColor: Colors.black,
                  //   labels: ['Upi Transfer', 'Bank Transfer'],
                  //   onToggle: (index) {
                  //     if (index == 0) {
                  //       paymentmethod = 1;
                  //     } else {
                  //       paymentmethod = 2;
                  //     }
                  //     print('switched to: $index');
                  //   },
                  // ),
                ],
              ),
              elevation: 10,
              content: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          autofocus: true,
                          enabled: (details["type"]) == 0 ? false : true,
                          controller: amountController,
                          style: TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixStyle:
                                  TextStyle(fontSize: 30, color: Colors.black),
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 30, color: Colors.grey[500]),
                              hintText: rs + '0'),
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
                                        details['todaysrate'].toString());
                                finalgram = gram.toStringAsFixed(3);
                              }
                            });
                          },
                        ),
                        h(10),
                        (_image == null)
                            ? InkWell(
                                onTap: () {
                                  setState(() {});
                                  getImage(setState);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xffE3E3E3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Upload Screenshot",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          w(5),
                                          Icon(Icons.file_upload_outlined,
                                              size: 18)
                                        ],
                                      ),
                                    )),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor("#EAEAEA"),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  image: DecorationImage(
                                    image: FileImage(File(_image.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30)),
                                        color: Colors.grey[500],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 8,
                                            top: 5,
                                            right: 5),
                                        child: Icon(Icons.close,
                                            size: 15, color: Colors.white),
                                      ),
                                      // child: IconButton(
                                      //   icon: Icon(Icons.close),
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       _image = null;
                                      //     });
                                      //   },
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
            ),
          );
        });
      },
    );
  }

  payBottomSheet() {
    return showModalBottomSheet(
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Stack(children: [
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
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // amountController.clear();
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                icon: Icon(Icons.close, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          autofocus: true,
                          // cursorHeight: 20,
                          enabled: (details["type"]) == 0 ? false : true,
                          controller: amountController,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefix: Text(rs),
                            // prefixText: rs,
                            prefixStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintText: "Enter Amount",
                            hintStyle: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
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
                                        details['todaysrate'].toString());
                                finalgram = gram.toStringAsFixed(3);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    h(15),
                    (_image == null)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {});
                              getImage(setState);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE3E3E3)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upload Screenshot",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      w(5),
                                      Icon(Icons.file_upload_outlined, size: 18)
                                    ],
                                  ),
                                )),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: HexColor("#EAEAEA"),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                image: FileImage(File(_image.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30)),
                                    color: Colors.grey[500],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8, top: 5, right: 5),
                                    child: Icon(Icons.close,
                                        size: 15, color: Colors.white),
                                  ),
                                  // child: IconButton(
                                  //   icon: Icon(Icons.close),
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       _image = null;
                                  //     });
                                  //   },
                                  // ),
                                ),
                              ),
                            ),
                          ),
                    h(30),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sentTap = true;
                        });
                        print(amountController.text.length);
                        if (details["type"] == 0) {
                          if (_image == null ||
                              amountController.text.length == 0) {
                            setState(() {
                              sentTap = false;
                            });
                            // if (transidController.text.toString().compareTo("") ==
                            //     0) {
                            //   showToastCenter(
                            //       "Please provide a screenshot of transaction to continue");
                            // } else {
                            //   pay(amountController.text.toString(), details['gram']);
                            // }
                            showToastCenter(
                                "Please input amount & provide a screenshot of transaction to continue");
                          } else
                            pay(amountController.text.toString(),
                                details['gram']);
                        } else {
                          if (_image == null ||
                              amountController.text.length == 0) {
                            setState(() {
                              sentTap = false;
                            });
                            showToastCenter(
                                "Please input amount & provide a screenshot of transaction to continue");
                          } else {
                            if (schemetype.toString().compareTo("1") == 0) {
                              if ((double.parse(
                                          amountController.text.toString()) <=
                                      double.parse(
                                          details["toamount"].toString())) &&
                                  (double.parse(
                                          amountController.text.toString()) >=
                                      double.parse(
                                          details["amount"].toString()))) {
                                if (currentstatus
                                        .toString()
                                        .compareTo("dialy") ==
                                    0) {
                                  pay(amountController.text.toString(),
                                      finalgram);
                                }

                                if (currentstatus
                                        .toString()
                                        .compareTo("dialy") !=
                                    0) {
                                  if (double.parse(
                                          amountController.text.toString()) <=
                                      double.parse(average.toString())) {
                                    pay(amountController.text.toString(),
                                        finalgram);
                                  } else {
                                    setState(() {
                                      sentTap = false;
                                    });
                                    showToastCenter(
                                        "Please enter amount below average");
                                  }
                                }
                              } else {
                                setState(() {
                                  sentTap = false;
                                });
                                showToastCenter(
                                    "Please enter amount with in range");
                              }
                            } else {
                              try {
                                if ((double.parse(
                                            amountController.text.toString()) <=
                                        double.parse(
                                            details["toamount"].toString())) &&
                                    (double.parse(
                                            amountController.text.toString()) >=
                                        double.parse(
                                            details["amount"].toString()))) {
                                  // Navigator.pop(context);

                                  if (_image == null) {
                                    if (transidController.text
                                            .toString()
                                            .compareTo("") ==
                                        0) {
                                      setState(() {
                                        sentTap = false;
                                      });
                                      showToastCenter(
                                          "Please provide a Transaction id or screenshot");
                                    } else {
                                      pay(amountController.text.toString(),
                                          finalgram);
                                    }
                                  } else {
                                    pay(amountController.text.toString(),
                                        finalgram);
                                  }
                                } else {
                                  setState(() {
                                    sentTap = false;
                                  });
                                  showToastCenter(
                                      "Please enter amount with in range");
                                }
                              } catch (e) {
                                setState(() {
                                  sentTap = false;
                                });
                                showToastCenter(
                                    "Please enter amount with in range");
                              }
                            }
                          }
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: accentClr),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: sentTap == true
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                        color: Colors.black),
                                    height: 20,
                                    width: 20)
                                : Text(
                                    "SEND",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 30),
                    ),
                  ],
                ),
              ),
            ]);
          });
        });
  }

////////////////paytm
//  void generateTxnToken(int mode) async {
//     setState(() {
//       loading = true;
//     });
//     String orderId = DateTime.now().millisecondsSinceEpoch.toString();

//     String callBackUrl = (testing
//             ? 'https://securegw-stage.paytm.in'
//             : 'https://securegw.paytm.in') +
//         '/theia/paytmCallback?ORDER_ID=' +
//         orderId;

//     //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
//     //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
//     var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

//     var body = json.encode({
//       "mid": mid,
//       "key_secret": PAYTM_MERCHANT_KEY,
//       "website": website,
//       "orderId": orderId,
//       "amount": amount.toString(),
//       "callbackUrl": callBackUrl,
//       "custId": "122",
//       "mode": mode.toString(),
//       "testing": testing ? 0 : 1
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: body,
//         headers: {'Content-type': "application/json"},
//       );
//       print("Response is");
//       print(response.body);
//       String txnToken = response.body;
//       setState(() {
//         payment_response = txnToken;
//       });

//       var paytmResponse = Paytm.payWithPaytm(
//           mid, orderId, txnToken, amount.toString(), callBackUrl, testing);

//       paytmResponse.then((value) {
//         print(value);
//         setState(() {
//           loading = false;
//           print("Value is ");
//           print(value);
//           if (value['error']) {
//             payment_response = value['errorMessage'];
//           } else {
//             if (value['response'] != null) {
//               payment_response = value['response']['STATUS'];
//             }
//           }
//           payment_response += "\n" + value.toString();
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

  // _openJioSavaan(data) async {
  //   String dt = data['JioSavaan'] as String;
  //   bool isInstalled =
  //       await DeviceApps.isAppInstalled('com.jio.media.jiobeats');
  //   if (isInstalled != false) {
  //     AndroidIntent intent = AndroidIntent(action: 'action_view', data: dt);
  //     await intent.launch();
  //   } else {
  //     String url = dt;
  //     if (await canLaunch(url))
  //       await launch(url);
  //     else
  //       throw 'Could not launch $url';
  //   }
  // }
}
