// // import 'dart:convert';
// //
// // import 'package:aradhana/Constants/Constants.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// // import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
// // import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
// // import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
// // import 'package:http/http.dart' as http;
// //
// // var cfPaymentGatewayService = CFPaymentGatewayService();
// // // @override
// // // void initState() {
// // //
// // //   cfPaymentGatewayService.setCallback(verifyPayment, onError);
// // // }
// //
// // class cfGetOrder {
// //   var cfPaymentGatewayService = CFPaymentGatewayService();
// //   static Future<dynamic> createOrder(
// //       orderId, orderAmt, customerId, name, email, phone) async {
// //     var response = await http.post(
// //       Uri.parse('https://sandbox.cashfree.com/pg/orders'),
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'x-client-id': cfAppID,
// //         'x-client-secret': cfSecretKey,
// //         'x-api-version': '2022-09-01',
// //         'x-request-id': 'Proaims',
// //       },
// //       body: jsonEncode({
// //         "order_amount": orderAmt,
// //         "order_id": orderId,
// //         "order_currency": "INR",
// //         "customer_details": {
// //           "customer_id": customerId,
// //           "customer_name": name,
// //           "customer_email": email,
// //           "customer_phone": phone
// //         }
// //       }),
// //     );
// //     var convertDataToJson;
// //     print(response.statusCode);
// //     if (response.statusCode == 200) {
// //       convertDataToJson = jsonDecode(response.body.toString());
// //       print(convertDataToJson);
// //       var cfOrderId = convertDataToJson["cf_order_id"];
// //       var paymntSessionId = convertDataToJson["payment_session_id"];
// //       var cfPaymentGatewayService = CFPaymentGatewayService();
// //
// //       // CFSession createPaymentSession() {
// //       CFEnvironment environment = CFEnvironment.SANDBOX;
// //       try {
// //         var session = createSession(environment, paymntSessionId, cfOrderId);
// //         List<CFPaymentModes> components = <CFPaymentModes>[];
// //         components.add(CFPaymentModes.UPI);
// //         components.add(CFPaymentModes.CARD);
// //         components.add(CFPaymentModes.WALLET);
// //         var paymentComponent =
// //             CFPaymentComponentBuilder().setComponents(components).build();
// //
// //         var theme = CFThemeBuilder()
// //             .setNavigationBarBackgroundColorColor("#FF0000")
// //             .setPrimaryFont("Menlo")
// //             .setSecondaryFont("Futura")
// //             .build();
// //
// //         var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
// //             .setSession(session)
// //             .setPaymentComponent(paymentComponent)
// //             .setTheme(theme)
// //             .build();
// //
// //         cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
// //       } on CFException catch (e) {
// //         print("```````````````````");
// //         print(e.message);
// //         print("```````````````````");
// //       }
// //
// //       return convertDataToJson;
// //     }
// //   }
// // }
// //
// // CFSession createSession(environment, paymntSessionId, cfOrderId) {
// //   try {
// //     var session = CFSessionBuilder()
// //         .setEnvironment(environment)
// //         .setOrderId(cfOrderId.toString())
// //         .setPaymentSessionId(paymntSessionId)
// //         .build();
// //     return session;
// //   } on CFException catch (e) {
// //     print(e.message);
// //   }
// //   return null;
// // }
// //
// // void verifyPayment(String orderId) {
// //   print("Verify Payment");
// // }
// //
// // void onError(CFErrorResponse errorResponse, String orderId) {
// //   print(errorResponse.getMessage());
// //   print("Error while making payment");
// // }
//
// import 'package:aradhana/Constants/Constants.dart';
// import 'package:aradhana/Util/Utils.dart';
// import 'package:aradhana/model/orderStatusModel.dart';
// import 'package:aradhana/model/paymentmodel.dart';
// import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
// import 'package:aradhana/screens/PaymentGateway/paymentSuccessScreen.dart';
// import 'package:aradhana/service/Paymentservice.dart';
// import 'package:aradhana/service/orderStatusService.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class paymentPage extends StatefulWidget {
//   final total;
//   final phone;
//   final email;
//   final amount;
//   final gram;
//   final paymntPednigId;
//   final orderID;
//
//   paymentPage({
//     this.total,
//     this.phone,
//     this.email,
//     this.amount,
//     this.gram,
//     this.paymntPednigId,
//     this.orderID,
//   });
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<paymentPage> {
//   Razorpay _razorpay = Razorpay();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(child: Center(child: CircularProgressIndicator())),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     openCheckout();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   void openCheckout() async {
//     var options = {
//       'key': razorpayKeyLive,
//       'name': 'Aradhana Jewellery',
//       'order_id': widget.orderID.toString(),
//       'timeout': 300,
//       'image':
//           'https://play-lh.googleusercontent.com/UaqkliiVpmCjRf1sK6MwTKp0btMMe7dr9NHsH3xncyUyIPJTnj6qWLQjYYW87tUllVJQ=w480-h960-rw',
//       'prefill': {'contact': widget.phone, 'email': widget.email}
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: ' + e.toString());
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     showToast("Payment success!");
//     print("order id! " + response.orderId.toString());
//     print(widget.total.toString());
//     print(widget.amount.toString());
//     //-------------agent pay api ------------>>>>>>>>>>>>>>>
//     agentpay(widget.amount, widget.gram, response.orderId.toString());
//     Map d = {
//       'orderId': widget.orderID.toString(),
//     };
//     OrderStatusModel preData = await orderStatusService.statusUpdate(d);
//     if (preData.success) {
//       print(preData.message);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 paymentSuccessScreen(id: widget.paymntPednigId)),
//       );
//     } else {
//       showToast("Something went wrong!");
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) async {
//     try {
//       showToast("Payment Failed! " + response.message.toString());
//       print("````````````````````````````````");
//       print(response.message.toString());
//       print("````````````````````````````````");
//
//       await Navigator.of(context).pushReplacementNamed(HomeTabs.routeName);
//     } catch (e) {
//       showToast(e.toString());
//       print(e.toString());
//     }
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) async {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName.toString(),
//         toastLength: Toast.LENGTH_LONG);
//     await Navigator.of(context).pushReplacementNamed(HomeTabs.routeName);
//   }
//
//   void agentpay(int amount, String gram, id) async {
//     Map details = {
//       'UserId': await getSavedObject('userid'),
//       'SheduledDateId': widget.paymntPednigId,
//       'gram': gram,
//       'amount': amount / 100,
//       'taransactionId': id.toString(),
//       'subscriptionId': await getSavedObject('subscription'),
//       'paidBy': await getSavedObject('userid')
//     };
//     print(details);
//     try {
//       EasyLoading.show(status: 'Loading...');
//       Paymentmodel datas = await Paymentservice.postPay(details);
//
//       EasyLoading.dismiss();
//       //widget.paymentrefresh();
//       // getProfile();
//     } catch (e) {
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       print(e);
//       //  Navigator.pop(context);
//     }
//   }
// }
