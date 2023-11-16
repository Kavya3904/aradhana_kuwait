import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/model/Recepitmodel.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/service/Paymentdetailsserivce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class paymentSuccessScreen extends StatefulWidget {
  final id;
  static String routeName = "/paymentSuccessScreen";

  const paymentSuccessScreen({Key key, this.id}) : super(key: key);

  @override
  State<paymentSuccessScreen> createState() => _paymentSuccessScreenState();
}

class _paymentSuccessScreenState extends State<paymentSuccessScreen> {
  Recepitmodel datas;
  bool load = true;
  bool _visible = true;

  @override
  void initState() {
    getPaymentdetails();
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      myFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: newButton40("Continue", () {
          Navigator.of(context).pushReplacementNamed(HomeTabs.routeName);
        }),
      )),
      body: load == true
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: 1,
                      duration: const Duration(milliseconds: 500),
                      child: Lottie.asset('assets/paymentDone.json',
                          repeat: false),
                    ),
                    testWidget()
                  ],
                ),
              ),
            ),
    );
  }

  void myFunction() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<Recepitmodel> getPaymentdetails() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'SheduledDateId': widget.id,
      'subscriptionId': await getSavedObject("subscription")
    };
//[[[
    try {
      EasyLoading.show(status: 'Loading...');
      datas = await Paymentdetailsservice.paymentDetails(details);
      var paidAmt = datas.data.paymentsDetails.amount;

      setState(() {
        load = false;
      });
      EasyLoading.dismiss();

      return datas;
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      return datas;
    }
  }

  Widget testWidget() {
    return ClipPath(
        clipper: MyClipper(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Column(
              children: [
                Image.asset("assets/receiptLogo.png", height: 60),
                h(10),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "Date: " +
                          DateFormat("dd-MM-yyyy")
                              .format(datas.data.paymentsDetails.paymentDate)
                              .toString()
                              .substring(0, 10),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                h(10),

                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),
                h(10),
                detail("Name : ", datas.data.paymentsDetails.name.toString()),

                detail("Registration Number : ",
                    datas.data.paymentsDetails.registrationNumber),
                detail("Phone : ", datas.data.paymentsDetails.phone.toString()),
                detail(
                    "Subscription Scheme Id : ",
                    "Sb-" +
                        datas.data.paymentsDetails.subscriptionId
                            .toString()
                            .padLeft(5, '0')),
                // detail("Transaction id : ",
                //     snapshot.data.data.paymentsDetails.taransactionId),
                detail(
                    "Receipt No. : ", datas.data.paymentsDetails.voucherNumber),
                // detail(
                //     "Full Amount  :  ", rs + paidAmt.toString().split('.')[0]),
                detail("Total Amount  :  ",
                    rs + datas.data.paymentsDetails.amount.split('.')[0]),
                // detail(
                //     "Tax Amount (3%) :  ", rs + cut.toString().split('.')[0]),

                h(10),
                // detail(
                //     "Date : ",
                //     DateFormat("dd-MM-yyyy")
                //         .format(snapshot.data.data.paymentsDetails.paymentDate)
                //         .toString()
                //         .substring(0, 10)),
                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),
                h(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    detail("Wallet Amount : ",
                        rs + datas.data.paymentsDetails.amount.split('.')[0]),
                    detail("Weight : ",
                        " " + datas.data.paymentsDetails.gram.toString())
                  ],
                ),
                h(10),

                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),

                h(20)
              ],
            ),
          ),
        ));
  }

  Widget detail(String title, String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            txt,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 10;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
