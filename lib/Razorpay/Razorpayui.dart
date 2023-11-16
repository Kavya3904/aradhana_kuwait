// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class Razorpayui extends StatefulWidget {
//    static String routeName = "/Razorpayui";
//   @override
//   _RazorpayState createState() => _RazorpayState();
// }

// class _RazorpayState extends State<Razorpayui> {
//   static const platform = const MethodChannel("razorpay_flutter");

//   Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

//     openCheckout();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_Srgjf0VsavtJ2A',
//       'amount': 2000,
//       'name': 'Proaims gold and diamond',
//       'description': 'Gold sceheme',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
     
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e);
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
//     Navigator.pop(context);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message,
//         timeInSecForIosWeb: 4);
//          Navigator.pop(context);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
