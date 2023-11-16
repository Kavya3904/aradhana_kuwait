import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/SubmitinputText.dart';
import 'package:aradhana/Widget/SubmitinputTextfocus.dart';
import 'package:aradhana/model/agentprofileviewmodel.dart';
import 'package:aradhana/model/profileeditpostmodel.dart';
import 'package:aradhana/service/profileeditservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class Agentprofile extends StatefulWidget {
  static String routeName = "/Agentprofile";
  @override
  _AgentprofileState createState() => _AgentprofileState();
}

class _AgentprofileState extends State<Agentprofile> {
  DateTime selectedDate = DateTime.now();
  FocusNode focus = FocusNode();

  Agentprofileviewmodel data = new Agentprofileviewmodel();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Profile", style: appBarTxtStyl),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: accentClr,
          icon: Icon(
            edit ? Icons.save : CupertinoIcons.pen,
            color: Colors.black,
          ),
          label: Text(edit ? "Save" : "Edit", style: size14_700),
          onPressed: () {
            if (!edit) {
              setState(() {
                edit = true;
              });
              Timer(Duration(seconds: 1), () {
                FocusScope.of(context).requestFocus(focus);
              });
            } else {
              if (nameController.text.toString().compareTo("") == 0) {
                showToast("Please enter name");
              } else if (adharController.text.toString().compareTo("") == 0 &&
                  pancardController.text.toString().compareTo("") == 0) {
                showToast("Please enter Pancard or Aadhaar card details");
              } else {
                // 'UserId': ' 3',
                Map b = {
                  "agentName": nameController.text.toString(),
                  "email": emailController.text.toString(),
                  "phone": data.data.userId.phone,
                  "pancard": pancardController.text.toString(),
                  "adhaar": adharController.text.toString(),
                  "address": addressController.text.toString(),
                };

                postedit(b);
              }
            }
          }),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, bottom: 0, top: 10),
                    child: SubmitTextInputTextfocus(
                      controller: nameController,
                      edit: edit,
                      fcous: focus,
                      label: "First Name",
                      keyboard: TextInputType.name,
                      hint: "",
                    ),
                  ),
                  SubmitTextInput(
                    textcolor: Colors.black,
                    controller: emailController,
                    edit: false,
                    label: "Email",
                    keyboard: TextInputType.emailAddress,
                    hint: "",
                  ),
                  SubmitTextInput(
                    textcolor: Colors.white,
                    controller: phoneController,
                    label: "Phone",
                    edit: false,
                    keyboard: TextInputType.phone,
                    hint: "",
                  ),
                  SubmitTextInput(
                    textcolor: Colors.white,
                    controller: adharController,
                    label: "Aadhaar",
                    edit: false,
                    keyboard: TextInputType.phone,
                    hint: "",
                  ),
                  SubmitTextInput(
                    textcolor: Colors.white,
                    controller: pancardController,
                    label: "Pan Card",
                    edit: false,
                    keyboard: TextInputType.text,
                    hint: "",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 15, bottom: 5),
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: TextField(
                          controller: addressController,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          minLines: 10,
                          enabled: edit,
                          textInputAction: TextInputAction.done,
                          maxLines: 15,
                          autocorrect: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: bgClr,
                            hintText: "Address",
                            hintStyle: TextStyle(color: HexColor("#262626")),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: appbarClr),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  h(MediaQuery.of(context).size.height * 0.1)
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //     child: Buttonwidget(
                  //       click: () {
                  //         if (!edit) {
                  //           setState(() {
                  //             edit = true;
                  //           });
                  //           Timer(Duration(seconds: 1), () {
                  //             FocusScope.of(context).requestFocus(focus);
                  //           });
                  //         } else {
                  //           if (nameController.text.toString().compareTo("") ==
                  //               0) {
                  //             showToast("Please enter name");
                  //           } else if (adharController.text
                  //                       .toString()
                  //                       .compareTo("") ==
                  //                   0 &&
                  //               pancardController.text
                  //                       .toString()
                  //                       .compareTo("") ==
                  //                   0) {
                  //             showToast(
                  //                 "Please enter Pancard or Aadhaar card details");
                  //           } else {
                  //             // 'UserId': ' 3',
                  //             Map b = {
                  //               "agentName": nameController.text.toString(),
                  //               "email": emailController.text.toString(),
                  //               "phone": data.data.userId.phone,
                  //               "pancard": pancardController.text.toString(),
                  //               "adhaar": adharController.text.toString(),
                  //               "address": addressController.text.toString(),
                  //             };
                  //
                  //             postedit(b);
                  //           }
                  //         }
                  //       },
                  //       label: edit ? "Save" : "Edit",
                  //       labelcolors: Colorsapps.buttonTextcolor,
                  //       height: 50,
                  //       width: 150,
                  //       colors: Colorsapps.buttonColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getProfileDetails() async {
    try {
      print("reached packaged");
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Agentprofileviewmodel datas =
          await Schemelistgetprofile.getprofileagent();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        EasyLoading.dismiss();
        data = datas;
        print(data);

        nameController.text = data.data.userId.agentName;
        emailController.text = data.data.userId.email;
        phoneController.text = data.data.userId.phone;
        pancardController.text = data.data.userId.panNumber;
        adharController.text = data.data.userId.adhaar;
        addressController.text = data.data.userId.address;

        //  test();
      });
    } catch (e) {
      showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> postedit(Map details) async {
    try {
      EasyLoading.show(status: 'Loading...');
      print(details);
      //    showLoading(context);

      Profileditpostmodel data =
          await Schemelistgetprofile.postprofileagentEdit(details);
      EasyLoading.dismiss();
      setState(() {
        edit = false;
      });

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
}
