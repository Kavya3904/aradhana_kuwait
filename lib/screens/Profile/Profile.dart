import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/Widget/SubmitinputText.dart';
import 'package:aradhana/Widget/newBottomDrawer.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/model/profileeditmodel.dart';
import 'package:aradhana/model/profileeditpostmodel.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:aradhana/service/profileeditservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../Widget/textCapitalization.dart';

class Profile extends StatefulWidget {
  static String routeName = "/Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // var inputClr = Color(0xff332d2e);
  bool loaddd = true;
  var dob = "";
  DateTime selectedDate = DateTime.now();
  FocusNode focus = FocusNode();
  // final DateFormat formatter = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dob = picked.toString().substring(0, 10);
      });
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //     output = formatter.format(selectedDate);
    //     dob = output.toString().substring(0, 10);
    //   });
  }

  Profileditmodel data = new Profileditmodel();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nomininameController = TextEditingController();

  TextEditingController nominirelationController = TextEditingController();
  TextEditingController nominiphonenumberController = TextEditingController();
  bool edit = false;
  int role;

  Sheduledmodel dataa;

  getNoti() async {
    // role = await getSavedObject("roleid");
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
        dataa = datas;
        loaddd = false;
      });
    } catch (e) {
      setState(() {
        loaddd = false;
      });
      EasyLoading.dismiss();
      Navigator.pop(context);
      print(e);
    }
    setState(() {
      role;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileDetails();
    // getNoti();
  }

  // getrole() async {
  //   role = await getSavedObject("roleid");
  //   getNoti();
  //
  //   print(role);
  //   //number= await getSavedObject("phone");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: Image.asset("assets/logoOnly.png", height: 40),
        centerTitle: true,
        leading: role == 2 || role == 4
            ? Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.sort, size: 30),
                      onPressed: () {
                        newDrawerr(
                            context, dataa.data.termsandcondtion.description);
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
                            dataa.data.notificationCount == 0
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
                                            dataa.data.notificationCount
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
      body: loaddd == true
          ? Opacity(opacity: 0)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  h(10),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [shadow],
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        color: inputClr),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          loaddd == false
                              ? Lottie.asset(
                                  'assets/fixedAssets/profileIcon.json',
                                  fit: BoxFit.fitHeight,
                                  frameRate: FrameRate(30),
                                  height: 100,
                                  repeat: false)
                              : CircularProgressIndicator(),
                          Container(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: nameController,
                              inputFormatters: [UpperCaseTextFormatter()],
                              enabled: edit,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: edit ? Colors.black : Colors.black54,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                isDense: false,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  h(10),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [shadow],
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        color: inputClr),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          newTxtfield(
                              Iconn: Icons.phone_outlined,
                              keyboard: TextInputType.phone,
                              textcolor: edit ? Colors.white : Colors.white54,
                              controller: phoneController,
                              edit: edit),
                          Divider(color: Colors.black54),
                          newTxtfield(
                              Iconn: Icons.email_outlined,
                              keyboard: TextInputType.emailAddress,
                              textcolor: edit ? Colors.white : Colors.white54,
                              controller: emailController,
                              edit: edit),
                        ],
                      ),
                    ),
                  ),
                  h(10),
                  Visibility(
                    visible: false,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Color(0xff7b582d)),
                            color: inputClr),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on,
                                  color: accentClr, size: 15),
                              Text(
                                "   ADD LOCATION",
                                style: font(14, accentClr, FontWeight.w400),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [shadow],
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                          color: inputClr),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 15.0, right: 15, bottom: 0, top: 10),
                            //   child: SubmitTextInputTextfocus(
                            //     controller: nameController,
                            //     edit: edit,
                            //     fcous: focus,
                            //     label: "Name",
                            //     keyboard: TextInputType.name,
                            //     hint: "",
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                if (edit) _selectDate(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25, bottom: 15),
                                child: Container(
                                  height: 55,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                child: dob.toString() == ""
                                                    ? Opacity(opacity: 0)
                                                    : Text(
                                                        DateFormat(
                                                                'dd  MMM, yyyy')
                                                            .format(
                                                                DateTime.parse(
                                                                    dob))
                                                            .toString(),
                                                        // dob.toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: edit
                                                                ? Colors.black
                                                                : Colors
                                                                    .black54,
                                                            fontSize: 13),
                                                      )),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: edit
                                                      ? Colors.black26
                                                      : Colors.black12,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              shape: BoxShape.rectangle),
                                        ),
                                      ),
                                      Positioned(
                                          left: 5,
                                          top: 0,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            color: inputClr,
                                            child: Text(
                                              'Date of Birth',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 5, top: 10),
                              child: SubmitTextInput(
                                textcolor: edit ? Colors.white : Colors.white54,
                                controller: adharController,
                                label: "Civil ID",
                                edit: edit,
                                keyboard: TextInputType.phone,
                                hint: "",
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 15.0, right: 15, bottom: 5),
                            //   child: SubmitTextInput(
                            //     textcolor: edit ? Colors.white : Colors.white54,
                            //     controller: pancardController,
                            //     label: "Pan Card",
                            //     edit: edit,
                            //     keyboard: TextInputType.text,
                            //     hint: "",
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 0, top: 5),
                              child: SubmitTextInput(
                                textcolor: edit ? Colors.white : Colors.white54,
                                controller: nomininameController,
                                edit: edit,
                                label: "Nominee Name",
                                keyboard: TextInputType.text,
                                hint: "",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 0, top: 10),
                              child: SubmitTextInput(
                                textcolor: edit ? Colors.white : Colors.white54,
                                controller: nominirelationController,
                                edit: edit,
                                label: "Nominee Relationship",
                                keyboard: TextInputType.text,
                                hint: "",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 0, top: 10),
                              child: SubmitTextInput(
                                textcolor: edit ? Colors.white : Colors.white54,
                                controller: nominiphonenumberController,
                                edit: edit,
                                label: "Nominee Phone Number",
                                keyboard: TextInputType.phone,
                                hint: "",
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 210,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15),
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10),
                                          child: TextField(
                                            controller: addressController,
                                            enabled: edit,
                                            cursorColor: Colors.black,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: edit
                                                    ? Colors.black
                                                    : Colors.black54,
                                                fontSize: 13),
                                            minLines: 10,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 15,
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: inputClr,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.black12)),
                                              // border: OutlineInputBorder(
                                              //     borderRadius: BorderRadius.all(
                                              //         Radius.circular(10.0)),
                                              //     borderSide: BorderSide(
                                              //         color: Colors.white12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: appbarClr)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black26)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 25,
                                        top: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          color: inputClr,
                                          child: Text(
                                            "Address",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: newButton(
                                  edit ? "Save" : "Update profile",
                                  () {
                                    if (!edit) {
                                      setState(() {
                                        edit = true;
                                      });
                                      Timer(Duration(seconds: 1), () {
                                        FocusScope.of(context)
                                            .requestFocus(focus);
                                      });
                                    } else {
                                      if (nameController.text
                                              .toString()
                                              .compareTo("") ==
                                          0) {
                                        showToast("Please enter name");
                                      } else {
                                        Map b = {
                                          "name":
                                              nameController.text.toString(),
                                          "email":
                                              emailController.text.toString(),
                                          "phone": data.data.userId.phone,
                                          "pancard":
                                              pancardController.text.toString(),
                                          "adhaarcard":
                                              adharController.text.toString(),
                                          "dob": dob,
                                          "referalId":
                                              data.data.userId.referalId,
                                          "address":
                                              addressController.text.toString(),
                                          "nominee_relation":
                                              nominirelationController.text
                                                  .toString(),
                                          "nominee_phone":
                                              nominiphonenumberController.text
                                                  .toString(),
                                          "nominee": nomininameController.text
                                              .toString(),
                                          "district": data.data.userId.district,
                                          "state": data.data.userId.state,
                                          "country": data.data.userId.country,
                                          "pincode": data.data.userId.pincode
                                        };
                                        print(b);
                                        {
                                          postedit(b);
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  getProfileDetails() async {
    await getNoti();
    try {
      print("reached packaged");
      EasyLoading.show(status: 'Loading...');
      Profileditmodel datas = await Schemelistgetprofile.getprofile();
      setState(() {
        EasyLoading.dismiss();
        data = datas;
        nameController.text = data.data.userId.name;
        emailController.text = data.data.userId.email;
        phoneController.text = data.data.userId.phone;
        pancardController.text = data.data.userId.pancard;
        adharController.text = data.data.userId.adhaarcard;
        addressController.text = data.data.userId.address;
        nominiphonenumberController.text = data.data.userId.nomineePhone;
        nomininameController.text = data.data.userId.nominee;
        nominirelationController.text = data.data.userId.nomineeRelation;
        if (data.data.userId.dob != null) {
          dob = data.data.userId.dob.toString().substring(0, 10);
        } else {
          dob = "";
        }
        loaddd = false;
      });
    } catch (e) {
      showErrorMessage(e);
      EasyLoading.dismiss();
    }
  }

  Future<void> postedit(Map details) async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Profileditpostmodel data =
          await Schemelistgetprofile.postprofileEdit(details);
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
