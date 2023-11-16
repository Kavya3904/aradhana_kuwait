// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:arabiangold/Constants/Constants.dart';
// import 'package:arabiangold/Screenagent/homescreen/agentdashboard.dart';
// import 'package:arabiangold/Util/Utils.dart';
// import 'package:arabiangold/Widget/ButtonWidget.dart';
// import 'package:arabiangold/model/Usermodel.dart';
// import 'package:arabiangold/screens/HomeScreen/SelectShemehomepage.dart';
// import 'package:arabiangold/screens/Packageselect/Selectpackagefirsttime.dart';
// import 'package:arabiangold/screens/Registrationpage/Registrationfirst.dart';
// import 'package:arabiangold/service/Userservice.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// class Otpscreen extends StatefulWidget {
//   static String routeName = "/otpscreen";
//   @override
//   _OtpscreenState createState() => _OtpscreenState();
// }
//
// class _OtpscreenState extends State<Otpscreen> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _smsController = TextEditingController();
//   String firebasetoken;
//   int i = 0;
//   TextEditingController textEditingController = TextEditingController();
//
//   String _message = '';
//   String _verificationId;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String mobilenumber;
//   StreamController<ErrorAnimationType> errorController;
//   bool hasError = false;
//   String currentText = "";
//
//   getFirebasetoken() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     // NotificationSettings settings = await messaging.requestPermission(
//     //   alert: true,
//     //   announcement: false,
//     //   badge: true,
//     //   carPlay: false,
//     //   criticalAlert: false,
//     //   provisional: false,
//     //   sound: true,
//     // );
//
//     // print('User granted permission: ${settings.authorizationStatus}');
//
//     firebasetoken = await messaging.getToken();
//     print(firebasetoken);
//   }
//
//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//
//     //    mobilenumber = ModalRoute.of(context).settings.arguments;
//
//     Future.delayed(Duration.zero, () async {
//       setState(() {
//         mobilenumber = ModalRoute.of(context).settings.arguments;
//       });
//       await _chkUser();
//       // setState(() {
//       //   mobilenumber = ModalRoute.of(context).settings.arguments;
//       // });
//       // _verifyPhoneNumber();
//       // getFirebasetoken();
//
// // not otp no login //
// //       getUserDetails();
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // _verifyPhoneNumber();
//     return Scaffold(
//         backgroundColor: bgClr,
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(left: 35, right: 35, bottom: 40),
//           child: newButton("NEXT", () {
//             print(textEditingController.text.toString());
//             _signInWithPhoneNumber(textEditingController.text.toString());
//
//             print("Completed");
//           }),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 15.0, right: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 100),
//               Text(
//                 "Enter verification code",
//                 style: font(29, Colors.white, FontWeight.w700),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                 child: FittedBox(
//                   child: Text("We sent you a verification code ",
//                       style: font(16, Colors.white54, FontWeight.w400)),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               PinCodeTextField(
//                 appContext: context,
//                 pastedTextStyle: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 length: 6,
//                 autoFocus: true,
//                 animationType: AnimationType.scale,
//                 pinTheme: PinTheme(
//                   disabledColor: inputClr,
//                   inactiveColor: inputClr,
//                   selectedFillColor: inputClr,
//                   inactiveFillColor: inputClr,
//                   selectedColor: Colors.white54,
//                   activeColor: inputClr,
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(5),
//                   fieldHeight: 50,
//                   fieldWidth: 40,
//                   activeFillColor: hasError ? inputClr : inputClr,
//                 ),
//                 cursorColor: Colors.white54,
//                 animationDuration: Duration(milliseconds: 300),
//                 backgroundColor: Colors.transparent,
//                 enableActiveFill: true,
//                 textStyle: font(18, Colors.white, FontWeight.w500),
//
//                 errorAnimationController: errorController,
//                 controller: textEditingController,
//                 keyboardType: TextInputType.number,
//                 boxShadows: [],
//                 onCompleted: (v) {
//                   print(textEditingController.text.toString());
//                   _signInWithPhoneNumber(textEditingController.text.toString());
//
//                   print("Completed");
//                 },
//                 // onTap: () {
//                 //   print("Pressed");
//                 // },
//                 onChanged: (value) {
//                   print(value);
//                   setState(() {
//                     currentText = value;
//                   });
//                 },
//                 beforeTextPaste: (text) {
//                   print("Allowing to paste $text");
//                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                   return true;
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Didn't receive it ?",
//                       style: font(14, Colors.white54, FontWeight.w400)),
//                   InkWell(
//                     child: Text(
//                       "  Resend OTP",
//                       style: font(14, Colors.white, FontWeight.bold),
//                     ),
//                     onTap: () {
//                       _verifyPhoneNumber();
//                     },
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//
//         // ),
//         );
//   }
//
//   // Example code of how to verify phone number
//   Future<void> _verifyPhoneNumber() async {
//     setState(() {
//       _message = '';
//     });
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);
//       showToast('Phone number verified.');
//       getUserDetails();
//     };
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       setState(() {
//         _message = 'Phone number verification failed.';
//       });
//     };
//
//     PhoneCodeSent codeSent =
//         (String verificationId, [int forceResendingToken]) async {
//       showToast('Please check your phone for the verification code.');
//       _verificationId = verificationId;
//     };
//
//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       _verificationId = verificationId;
//     };
//
//     // var test = FirebaseAuth.instanceFor().currentUser.getIdToken();
//
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: mobilenumber,
//           timeout: const Duration(seconds: 35),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       showToast('Failed to Verify Phone Number: $e');
//     }
//   }
//
//   // Example code of how to sign in with phone.
//   Future<void> _signInWithPhoneNumber(String number) async {
//     print("submitted" + number);
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: number,
//       );
//       final User user = (await _auth.signInWithCredential(credential)).user;
//       getUserDetails();
//       print("reached");
//       // showToast('Successfully signed in UID: ${user.uid}');
//     } catch (e) {
//       print("```````````````````````e```````````````````````");
//       print(e);
//       print("```````````````````````e```````````````````````");
//
//       showToast("Failed to sign in");
//     }
//   }
//
//   Future<void> getUserDetails() async {
//     try {
//       Map b = {"phone": mobilenumber, "FcmToken": firebasetoken};
//       print(firebasetoken);
//       EasyLoading.show(status: 'Loading...');
//       //    showLoading(context);
//       Usermodel datas = await UserService.login(b);
//       EasyLoading.dismiss();
//       print(datas.message);
//       if (datas.data.islogin) {
//         if (datas.data.roleId == 3) {
//           // Navigator.pushReplacementNamed(context, Agenthomescreen.routeName,
//           //     arguments: mobilenumber);
//           Navigator.pushNamedAndRemoveUntil(context,
//               AgentDashboardhome.routeName, (Route<dynamic> route) => false);
//         } else {
//           if (datas.data.subscriptionList.isEmpty) {
//             Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 Selectpackagefirsttime.routeName,
//                 (Route<dynamic> route) => false);
//           } else {
//             Navigator.pushNamedAndRemoveUntil(context, SelectScheme.routeName,
//                 (Route<dynamic> route) => false);
//
//             // Navigator.pushReplacementNamed(context, SelectScheme.routeName);
//           }
//         }
//       } else {
//         Navigator.pushReplacementNamed(context, Registration.routeName,
//             arguments: mobilenumber);
//       }
//       //  Navigator.of(context).pop(true);
//       // showLoading(context);
//       // setState(() {
//       //   EasyLoading.dismiss();
//       //   data = datas;
//       //   print(data);
//       //   //  test();
//       // });
//     } catch (e) {
//       print(e);
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       //  Navigator.pop(context);
//     }
//   }
//
//   Future<void> _chkUser() {
//     print(mobilenumber);
//     if (mobilenumber.toString() == "+919562044475") {
//       print("workinggg");
//       getUserDetails();
//     } else {
//       print("regularr");
//
//       _verifyPhoneNumber();
//       getFirebasetoken();
//     }
//   }
// }
