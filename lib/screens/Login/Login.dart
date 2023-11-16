import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/screens/Otp/Otpscreen_copy.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/Constants.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String countrycode = "+965";
  TextEditingController mobilenumberController = new TextEditingController();
  // String firebasetoken;
  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{6,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      showToast('Please enter mobile number');
      return false;
    } else if (!regExp.hasMatch(value)) {
      showToastCenter('Please enter valid mobile number');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _design2();
  }

  _design2() {
    var ss = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: bgClr,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: bgClr,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Text("Login",
                    style: font(22, Colors.black, FontWeight.w700)),
                onTap: () {
                  if (validateMobile(mobilenumberController.text.toString())) {
                    String args =
                        countrycode + mobilenumberController.text.toString();
                    Navigator.pushNamed(context, Otpscreen.routeName,
                        arguments: args);
                  }
                },
              ),
              h(15),
              Text(
                "Enter your mobile number below. \nYou'll receive an sms with OTP",
                style: font(14, Colors.black, FontWeight.w400),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 30,
              ),
              Text("Enter Your Phone Number",
                  style: font(13, Colors.black54, FontWeight.w400)),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: inputClr,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      CountryCodePicker(
                        enabled: true,
                        padding: EdgeInsets.zero,
                        boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        showFlagMain: true,
                        onChanged: (print) {
                          countrycode = print.dialCode;
                        },

                        textStyle: font(14, Colors.black, FontWeight.w600),
                        initialSelection: '+965',
                        // favorite: ['+91', '+93'],
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: false,
                        showFlag: true,
                        showFlagDialog: true,
                        backgroundColor: Colors.white,
                        // showDropDownButton: true,
                        alignLeft: false,
                      ),
                      VerticalDivider(
                          color: Colors.black54, indent: 10, endIndent: 10),
                      Expanded(
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: inputClr,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: mobilenumberController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  style:
                                      font(14, Colors.black, FontWeight.w600),
                                  decoration: InputDecoration(
                                    hintStyle: font(
                                        14, Colors.black54, FontWeight.w400),
                                    hintText: ' Mobile number',
                                    border: InputBorder.none,
                                  ),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Spacer(),
              newButton("Next", () {
                if (validateMobile(mobilenumberController.text.toString())) {
                  String args =
                      countrycode + mobilenumberController.text.toString();
                  print("```````args```````");
                  print(args);
                  Navigator.pushNamed(context, Otpscreen.routeName,
                      arguments: args);
                }
              }),
              h(20)
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: roundButton(
              //       Icons.arrow_forward,
              //       () {
              //         if (validateMobile(
              //             mobilenumberController.text.toString())) {
              //           String args = countrycode +
              //               mobilenumberController.text.toString();
              //           Navigator.pushNamed(context, Otpscreen.routeName,
              //               arguments: args);
              //         }
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
