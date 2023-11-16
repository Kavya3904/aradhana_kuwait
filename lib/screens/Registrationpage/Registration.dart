import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/Widget/Inputdropdown.dart';
import 'package:aradhana/Widget/Messageutil.dart';
import 'package:aradhana/Widget/TextfliedWidget.dart';
import 'package:aradhana/model/BranchListModel.dart';
import 'package:aradhana/model/Countymodel.dart';
import 'package:aradhana/model/Registrationmodel.dart';
import 'package:aradhana/model/districtmodel.dart';
import 'package:aradhana/model/statemodel.dart';
import 'package:aradhana/screens/Packageselect/Selectpackage.dart';
import 'package:aradhana/service/Registrationservice.dart';
import 'package:aradhana/service/branchservice.dart';
import 'package:aradhana/service/locationservice.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../model/referal_model.dart';

class Registerationsecond extends StatefulWidget {
  static String routeName = "/Registerationsecond";

  @override
  _RegisterationsecondState createState() => _RegisterationsecondState();
}

class _RegisterationsecondState extends State<Registerationsecond> {
  List<String> countrys = [];
  List<int> countryid = [];
  List<String> states = [];
  List<int> stateid = [];
  List<String> districts = [];
  List<int> districtid = [];
  List<String> branch = [];
  List<int> branchid = [];
  Map phone = new Map();
  String selectedstate;
  Map details;
  String selecteddistrict;
  String dob;
  bool v = false;
  String selectedcountry;
  String selectedbranch;
  ReferalModal referalModal;
  File _image;
  final picker = ImagePicker();

  bool showState = false;
  bool showDistrict = false;
  bool showPIN = false;
  bool extraDetails = false;

  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController nomininameController = TextEditingController();
  TextEditingController nominirelationController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController nominiphoneController = TextEditingController();
  TextEditingController refereid = TextEditingController();
  String firebasetoken;
  GlobalKey _toolTipKey = GlobalKey();
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
    Future.delayed(Duration.zero, () {
      setState(() {
        details = ModalRoute.of(context).settings.arguments;
        refereid.text = "AGKW1001";
      });
    });

    getFirebasetoken();
    getBranch();
    getRefaral();
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var ss = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: bgClr,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ss.height * 0.1),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            title: Text("Welcome",
                style: font(14, Colors.black54, FontWeight.w400)),
            backgroundColor: bgClr,
          ),
        ),
        body: Column(
          children: [
            Text("Create an account",
                style: font(15, Colors.black, FontWeight.w500)),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 20),
                          child: Text("Select your Branch",
                              style: font(12, Colors.black, FontWeight.w400)),
                        ),
                        SubmitSelectInputBorderBlack(
                          label: "",
                          dropdownValue: selectedbranch,
                          hint: " Select Branch",
                          listvalues: branch,
                          onChanged: (value) {
                            setState(() {
                              selectedbranch = value;
                              selectedcountry = null;
                              selecteddistrict = null;
                              selectedstate = null;
                            });

                            print(selectedbranch);
                            getCountry(branchid
                                .elementAt(branch.indexOf(selectedbranch)));
                          },
                        ),
                        Visibility(
                          visible: extraDetails,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 15),
                                  child: Textfliedwidget(
                                      edit: nomininameController,
                                      label: "Nominee",
                                      keyboard: TextInputType.emailAddress),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 15),
                                  child: Textfliedwidget(
                                      edit: nominiphoneController,
                                      label: "Nominee Phone",
                                      keyboard: TextInputType.phone),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 15),
                                  child: Textfliedwidget(
                                      edit: nominirelationController,
                                      label: "Nominee Relation",
                                      keyboard: TextInputType.emailAddress),
                                ),
                                Divider(
                                  color: HexColor("#D4D4D4"),
                                  thickness: 1.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10.0,
                                      right: 15,
                                      bottom: 15),
                                  child: Text("Pan Card or Aadhaar Card",
                                      style: TextStyle(
                                          color: HexColor("#000000"))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 15),
                                  child: Textfliedwidget(
                                      edit: pancardController,
                                      label: "Pan Card",
                                      keyboard: TextInputType.text),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 15),
                                  child: Textfliedwidget(
                                      edit: adharController,
                                      label: "Aadhaar Card",
                                      keyboard: TextInputType.number),
                                ),
                                Divider(
                                  color: HexColor("#D4D4D4"),
                                  thickness: 1.5,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25, bottom: 10),
                                  child: Messageview(
                                    controller: messageController,
                                    height: 200,
                                    label: "Address",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text("Select your Country",
                              style: font(12, Colors.black, FontWeight.w400)),
                        ),
                        SubmitSelectInputBorderBlack(
                          label: "",
                          dropdownValue: selectedcountry,
                          hint: "Country",
                          listvalues: countrys,
                          onChanged: (value) {
                            setState(() {
                              selectedcountry = value;
                              selectedstate = null;
                              selecteddistrict = null;
                              showState = false;
                              showDistrict = true;
                            });
                            getDistrict(countryid
                                .elementAt(countrys.indexOf(selectedcountry))
                                .toString());
                            print("country id : " +
                                countryid
                                    .elementAt(
                                        countrys.indexOf(selectedcountry))
                                    .toString()
                                    .toString());
                            // getState(countryid
                            //     .elementAt(countrys.indexOf(selectedcountry))
                            //     .toString());
                          },
                        ),
                        Visibility(
                          visible: showState,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 15, top: 10),
                            child: Text("Select your State",
                                style: font(12, Colors.black, FontWeight.w400)),
                          ),
                        ),
                        Visibility(
                          visible: showState,
                          child: SubmitSelectInputBorderBlack(
                            label: "",
                            dropdownValue: selectedstate,
                            hint: "State",
                            listvalues: states,
                            onChanged: (value) {
                              setState(() {
                                selectedstate = value;
                                selecteddistrict = null;
                                showDistrict = true;
                              });
                              getDistrict(stateid
                                  .elementAt(states.indexOf(selectedstate))
                                  .toString());
                            },
                          ),
                        ),
                        Visibility(
                          visible: showDistrict,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 15, top: 10),
                            child: Text("Select City",
                                style: font(12, Colors.black, FontWeight.w400)),
                          ),
                        ),
                        Visibility(
                          visible: showDistrict,
                          child: SubmitSelectInputBorderBlack(
                            label: "",
                            dropdownValue: selecteddistrict,
                            hint: "City",
                            listvalues: districts,
                            onChanged: (value) {
                              setState(() {
                                selecteddistrict = value;
                                showPIN = true;
                              });
                            },
                          ),
                        ),
                        // Visibility(
                        //   visible: showPIN,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 15, right: 15, bottom: 5),
                        //     child: TextfliedwidgetBlack(
                        //         edit: pincodeController,
                        //         label: "Pincode",
                        //         keyboard: TextInputType.number),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 25.0, right: 15, top: 10, bottom: 10),
                        //   child: Text("Referal Code",
                        //       style: font(14, Colors.black, FontWeight.w400)),
                        // ),
                        // Divider(color: Colors.black54),
                        // Visibility(
                        //   visible: true,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 25, right: 15, bottom: 5, top: 5),
                        //     child: Text(
                        //       "Nominee Details",
                        //       style: TextStyle(color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15.0, right: 15, bottom: 0, top: 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(5))),
                        //     child: CapsTextfliedwidgetBlack(
                        //         edit: nomininameController,
                        //         label: "Nominee Name",
                        //         keyboard: TextInputType.text),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15.0, right: 15, bottom: 5, top: 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(5))),
                        //     child: TextfliedwidgetBlack(
                        //         edit: nominirelationController,
                        //         label: "Nominee Relation",
                        //         keyboard: TextInputType.text),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15.0, right: 15, bottom: 5, top: 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(5))),
                        //     child: TextfliedwidgetBlack(
                        //         edit: nominiphoneController,
                        //         label: "Nominee Phone",
                        //         keyboard: TextInputType.phone),
                        //   ),
                        // ),
                        // Divider(color: Colors.black54),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15.0, right: 15, bottom: 0, top: 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(5))),
                        //     child: TextfliedwidgetBlack(
                        //         edit: adharController,
                        //         label: "Aadhaar Number",
                        //         keyboard: TextInputType.number),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, bottom: 5, top: 0),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextfliedwidgetBlack(
                                edit: refereid,
                                label: "Referral Code",
                                keyboard: TextInputType.text),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (selectedbranch == null) {
                                    showToast("Please select a branch");
                                  } else {
                                    final link = WhatsAppUnilink(
                                      phoneNumber: phone[branchid.elementAt(
                                          branch.indexOf(selectedbranch))],
                                      text:
                                          "Hi, I would like to join Aradhana Gold And Diamonds Kuwait scheme. Can you please provide a referral code.",
                                    );
                                    await launch('$link');
                                  }
                                },
                                child: const Text(
                                  "Don't you have referral code ?",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(127, 203, 163, 1)),
                                ),
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Color.fromRGBO(127, 203, 163, 1),
                                ),
                                onPressed: () async {
                                  if (selectedbranch == null) {
                                    showToast("Please select a branch");
                                  } else {
                                    final link = WhatsAppUnilink(
                                      phoneNumber: phone[branchid.elementAt(
                                          branch.indexOf(selectedbranch))],
                                      text:
                                          "Hi, I would like to join Aradhana Gold And Diamonds Kuwait scheme. Can you please provide a referral code.",
                                    );
                                    await launch('$link');
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        h(ss.height * 0.05),
                        //button

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: newButton("Submit", () {
                            if (refereid.text.toString().compareTo("") == 0) {
                              showToast(
                                  "Please enter referral code, If you don't have reference code please contact admin using WhatsApp");
                            } else if (selectedbranch == null) {
                              showToast("Please select branch");
                              return;
                            } else if (selectedcountry == null) {
                              showToast("Please select country");
                              return;
                            } else if (selecteddistrict == null) {
                              showToast("Please select district");
                              return;
                            } else {
                              Map b = {
                                "name": details['name'],
                                "email": details['email'],
                                "phone": details['mobile'],
                                "dob": details['date'],
                                "referalId": refereid.text.toString(),
                                "FcmToken": firebasetoken,
                                "district": districtid.elementAt(
                                  districts.indexOf(selecteddistrict),
                                ),
                                "branchId": branchid
                                    .elementAt(branch.indexOf(selectedbranch)),
                                "country": countryid.elementAt(
                                    countrys.indexOf(selectedcountry))
                              };
                              postRegistration(b);
                            }
                          }),
                        ),
                        h(ss.height * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> getCountry(int branchid) async {
    countryid.clear();
    countrys.clear();
    states.clear();
    districtid.clear();
    districts.clear();
    stateid.clear();

    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Countrymodel country = await Locationservice.getCountry(branchid);
      EasyLoading.dismiss();
      setState(() {
        countrys = country.data.countryList.map((e) => e.countryName).toList();
        countryid = country.data.countryList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> getState(String id) async {
    districtid.clear();
    districts.clear();
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Statemodel state = await Locationservice.getState(id);
      EasyLoading.dismiss();
      setState(() {
        states = state.data.stateList.map((e) => e.stateName).toList();
        stateid = state.data.stateList.map((e) => e.id).toList();
      });
      // country.data.countryList.forEach((element) {
      //   countrys.add(element.countryName);
      //   countryid.add(element.id);
      // });

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

  Future<void> getDistrict(String id) async {
    try {
      EasyLoading.show(status: 'Loading...');
      Districtmodel district = await Locationservice.getDistrict(id);
      EasyLoading.dismiss();
      setState(() {
        districts =
            district.data.districtsList.map((e) => e.districtName).toList();
        districtid = district.data.districtsList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);

      EasyLoading.dismiss();
    }
  }

  Future<void> postRegistration(Map details) async {
    try {
      EasyLoading.show(status: 'Loading...');

      Registrationmodel data =
          await Registrationservice.getRegistration(details);
      EasyLoading.dismiss();
      Navigator.pushNamedAndRemoveUntil(
          context, SelectPackage.routeName, (Route<dynamic> route) => false);
    } catch (e) {
      print(e);

      EasyLoading.dismiss();
    }
  }

  Future<void> getBranch() async {
    branch.clear();
    branchid.clear();

    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      BranchListModel branchs = await Branchservice.getBranch();
      EasyLoading.dismiss();
      setState(() {
        branch = branchs.data.branches.map((e) => e.name).toList();
        branchid = branchs.data.branches.map((e) => e.id).toList();
      });

      // getCountry(branchid.elementAt(0));
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> getRefaral() async {
    try {
      phone.clear();
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      ReferalModal branchs = await Branchservice.getRefaral();
      EasyLoading.dismiss();

      branchs.data.defaultRefaral.forEach((element) {
        //Map b = {element.branchId: element.reqMob};
        phone[element.branchId] = element.reqMob;
      });

//       setState(() {
//         phone = branchs.data.defaultRefaral.map((e) {
// Map b= {e.id,e.reqMob}

//          }).toList();
//         // branchidforphone =
//         //     branchs.data.defaultRefaral.map((e) => e.id).toList();
//       });
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
