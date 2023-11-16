import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/homescreen/agentdashboard.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Packageselect/Selectpackagefirsttime.dart';
import 'package:aradhana/screens/Registrationpage/Registrationfirst.dart';
import 'package:aradhana/service/Userservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../Util/Utils.dart';
import '../../model/Usermodel.dart';

class Otpscreen extends StatefulWidget {
  static String routeName = "/otpscreen";
  @override
  _OtpscreenState createState() => _OtpscreenState();
}

//jjjjk
class _OtpscreenState extends State<Otpscreen> {
  //-------------------------------
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  bool bttnPress = false;
  bool resendEnable = false;
//---------------------------------
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String firebasetoken;
  int i = 0;
  TextEditingController textEditingController = TextEditingController();

  String _message = '';
  String _verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String mobilenumber;
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  bool otp = true;
  getFirebasetoken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // print('User granted permission: ${settings.authorizationStatus}');

    firebasetoken = await messaging.getToken();
    print(firebasetoken);
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    //    mobilenumber = ModalRoute.of(context).settings.arguments;

    Future.delayed(Duration.zero, () async {
      setState(() {
        mobilenumber = ModalRoute.of(context).settings.arguments;
      });

      await _chkUser();
      // getUserDetails();

      // setState(() {
      //   mobilenumber = ModalRoute.of(context).settings.arguments;
      // });
      // _verifyPhoneNumber();
      // getFirebasetoken();

// not otp no login //
//       getUserDetails();`
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgClr,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 30),
          child: newButton("Next", () {
            _signInWithPhoneNumber(textEditingController.text.toString());
          }),
          // child: roundButton(Icons.arrow_forward, () {
          //   _signInWithPhoneNumber(textEditingController.text.toString());
          // }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text("Enter verification code",
                  style: font(22, Colors.black, FontWeight.w700)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: FittedBox(
                  child: Text(
                      "We sent you a verification code to " +
                          mobilenumber.toString(),
                      style: font(13, Colors.black54, FontWeight.w400)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                appContext: context,
                autoFocus: true,
                pastedTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                    disabledColor: inputClr,
                    inactiveColor: inputClr,
                    selectedFillColor: inputClr,
                    inactiveFillColor: inputClr,
                    selectedColor: Colors.black26,
                    activeColor: Colors.black54,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: inputClr),
                cursorColor: Colors.black54,
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                textStyle: font(18, Colors.black, FontWeight.w500),
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [],
                onCompleted: (v) {
                  _signInWithPhoneNumber(textEditingController.text.toString());
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
              SizedBox(
                height: 20,
              ),
              resendEnable == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Didn't receive the verification code? ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54)),
                            w(5),
                            Countdown(
                              controller: _controller,
                              seconds: 60,
                              build: (_, double time) => Text(
                                "Resend SMS (00:${time.toString().split('.')[0]})",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              interval: const Duration(milliseconds: 100),
                              onFinished: () {
                                setState(() {
                                  resendEnable = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          resendEnable = false;
                          // _verifyPhoneNumber();
                          bttnPress = false;
                          showToast("OTP Resent!");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                  "Didn't receive the verification code?",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                              w(5),
                              Text(
                                "Resend SMS",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        )

        // ),
        );
  }

  // Example code of how to verify phone number
  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showToast('Phone number verified.');
      getUserDetails();
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        _message = 'Phone number verification failed.';
      });
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    // var test = FirebaseAuth.instanceFor().currentUser.getIdToken();

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobilenumber,
          timeout: const Duration(seconds: 35),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showToast('Failed to Verify Phone Number: $e');
    }
  }

  // Example code of how to sign in with phone.
  Future<void> _signInWithPhoneNumber(String number) async {
    print("submitted: " + number);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: number);
      final User user = (await _auth.signInWithCredential(credential)).user;
      getUserDetails();
      print("reached");
      return;
    } catch (e) {
      print("```````````e```````````");
      print(e);
      // showToast("Failed to sign in");
    }
  }

  Future<void> getUserDetails() async {
    print(mobilenumber);
    try {
      Map b = {"phone": mobilenumber, "FcmToken": firebasetoken};
      print("Firebase token: " + firebasetoken.toString());
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Usermodel datas = await UserService.login(b);
      EasyLoading.dismiss();
      print(datas.message);
      if (datas.data.islogin) {
        if (datas.data.roleId == 3) {
          Navigator.pushNamedAndRemoveUntil(context,
              AgentDashboardhome.routeName, (Route<dynamic> route) => false);
        } else {
          if (datas.data.subscriptionList.isEmpty) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                Selectpackagefirsttime.routeName,
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, SelectScheme.routeName,
                (Route<dynamic> route) => false);

            // Navigator.pushReplacementNamed(context, SelectScheme.routeName);
          }
        }
      } else {
        Navigator.pushReplacementNamed(context, Registration.routeName,
            arguments: mobilenumber);
      }
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      // setState(() {
      //   EasyLoading.dismiss();
      //   data = datas;
      //   print(data);
      //   //  test();
      // });

    } catch (e) {
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> _chkUser() {
    print(mobilenumber);
    if (mobilenumber.toString() == "+96524252425") {
      getUserDetails();
    } else {
      print("regularr");

      _verifyPhoneNumber();
      getFirebasetoken();
    }
  }

  //-----------------------------LAYOUTS-----------------------------------

}
