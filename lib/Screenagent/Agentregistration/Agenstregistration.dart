import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/Widget/Inputdropdown.dart';
import 'package:aradhana/Widget/Messageutil.dart';
import 'package:aradhana/Widget/TextfliedWidget.dart';
import 'package:aradhana/model/Countymodel.dart';
import 'package:aradhana/model/agentregisterationmodel.dart';
import 'package:aradhana/model/districtmodel.dart';
import 'package:aradhana/model/statemodel.dart';
import 'package:aradhana/service/Registrationservice.dart';
import 'package:aradhana/service/locationservice.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class Agenstregistration extends StatefulWidget {
  static String routeName = "/Agenstregistration";

  @override
  _AgenstregistrationState createState() => _AgenstregistrationState();
}

class _AgenstregistrationState extends State<Agenstregistration> {
  String countrycode = "+91";
  List<String> countrys = [];
  List<int> countryid = [];
  List<String> states = [];
  List<int> stateid = [];
  List<String> districts = [];
  List<int> districtid = [];
  // List<String> branch = [];
  // List<int> branchid = [];
  String selectedstate;
  String selectedbranch;
  //String mobilenumber;
  String selecteddistrict;
  String dob;
  String selectedcountry;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController nomininameController = TextEditingController();
  TextEditingController nominirelationController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController nominiphoneController = TextEditingController();
  TextEditingController refereid = TextEditingController();
  File _image;
  final picker = ImagePicker();
//```````````````````````````
  bool showState = false;
  bool showDistrict = false;
  //````````````````````````
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
  void initState() {
    //getCountry();
    super.initState();
    getAgent();
    // getBranch();
    // getRefaral();
  }
//  Future<void> getRefaral() async {
//     try {
//       phone.clear();
//       EasyLoading.show(status: 'Loading...');
//       //    showLoading(context);
//       ReferalModal branchs = await Branchservice.getRefaral();
//       EasyLoading.dismiss();

//       branchs.data.defaultRefaral.forEach((element) {
//         //Map b = {element.branchId: element.reqMob};
//         phone[element.branchId]=element.reqMob;
//       });

// //       setState(() {
// //         phone = branchs.data.defaultRefaral.map((e) {
// // Map b= {e.id,e.reqMob}

// //          }).toList();
// //         // branchidforphone =
// //         //     branchs.data.defaultRefaral.map((e) => e.id).toList();
// //       });
//     } catch (e) {
//       print(e);
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       //  Navigator.pop(context);
//     }
//   }
  DateTime selectedDate = DateTime.now();
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
        dateofbirthcontroller.text = dob;
      });
  }

  String agentid = "";
  int branchid;
  getAgent() async {
    String s = await getSavedObject("referalId");
    int branch = await getSavedObject("branch");

    print(branch);
    if (s != null) agentid = s;
    if (branch != null) branchid = branch;
    getCountry(branchid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Registration", style: appBarTxtStyl),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfliedwidgetBlack(
                    edit: nameController,
                    label: "Name",
                    keyboard: TextInputType.name,
                  ),
                  TextfliedwidgetBlack(
                      edit: emailController,
                      label: "Email",
                      keyboard: TextInputType.emailAddress),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black26)),
                              child: Row(
                                children: [
                                  w(10),
                                  FaIcon(FontAwesomeIcons.mobileAlt,
                                      size: 13, color: Colors.black54),
                                  CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    onChanged: (print) {
                                      countrycode = print.dialCode;
                                    },
                                    textStyle: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("#645D5D"),
                                    ),
                                    initialSelection: '+695',
                                    favorite: ['+91', '+93'],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    showFlag: false,
                                    showFlagDialog: true,
                                    alignLeft: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 15),
                              child: TextfliedwidgetBlack(
                                  edit: phoneController,
                                  label: "Phone",
                                  keyboard: TextInputType.number),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 15, bottom: 15),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: TextField(
                                controller: dateofbirthcontroller,
                                style: font(15, Colors.black, FontWeight.w500),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabled: false,
                                  hintText: "Date Of Birth",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              )),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  TextfliedwidgetBlack(
                      edit: nomininameController,
                      label: "Nominee Name",
                      keyboard: TextInputType.emailAddress),
                  TextfliedwidgetBlack(
                      edit: nominiphoneController,
                      label: "Nominee Phone",
                      keyboard: TextInputType.phone),
                  TextfliedwidgetBlack(
                      edit: nominirelationController,
                      label: "Nominee Relation",
                      keyboard: TextInputType.emailAddress),
                  // div,
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 10.0, right: 15, bottom: 15, top: 10),
                  //   child:
                  //       Text("Pan Card Or Aadhaar Card", style: smallHeading),
                  // ),
                  // Textfliedwidget(
                  //     edit: pancardController,
                  //     label: "Pan Card",
                  //     keyboard: TextInputType.text),
                  // Textfliedwidget(
                  //     edit: adharController,
                  //     label: "Aadhaar Card",
                  //     keyboard: TextInputType.number),
                  // TextfliedwidgetBlack(
                  //     edit: pincodeController,
                  //     label: "Pincode",
                  //     keyboard: TextInputType.number),
                  // div,
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 10, left: 10.0, right: 15, bottom: 15),
                  //   child: Text("Upload Aadhaar Card", style: smallHeading),
                  // ),
                  // (_image == null)
                  //     ? Padding(
                  //         padding: const EdgeInsets.only(left: 25.0, right: 25),
                  //         child: Container(
                  //           height: 55,
                  //           width: MediaQuery.of(context).size.width,
                  //           decoration: BoxDecoration(
                  //               // color: HexColor("#720755"),
                  //               border: Border.all(
                  //                 color: Colors.black54,
                  //               ),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(5))),
                  //           child: InkWell(
                  //             onTap: () {
                  //               getImage();
                  //             },
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text("Upload", style: size14_700),
                  //                 Icon(
                  //                   Icons.upload,
                  //                   color: Colors.black,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Padding(
                  //         padding: const EdgeInsets.only(left: 25.0, right: 25),
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: 100,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: HexColor("#720755"),
                  //             ),
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(5)),
                  //             image: DecorationImage(
                  //               image: FileImage(File(_image.path)),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           child: Align(
                  //             alignment: Alignment.topRight,
                  //             child: Container(
                  //               color: Colors.blueGrey,
                  //               child: IconButton(
                  //                 icon: Icon(Icons.close),
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     _image = null;
                  //                   });
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  // SizedBox(height: 15),
                  div,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15, bottom: 10, top: 10),
                    child: Text("Location", style: smallHeading),
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
                    },
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
                    child: SubmitSelectInputBorderBlack(
                      label: "",
                      dropdownValue: selecteddistrict,
                      hint: "City",
                      listvalues: districts,
                      onChanged: (value) {
                        setState(() {
                          selecteddistrict = value;
                        });
                      },
                    ),
                  ),
                  h(10),
                  div,
                  h(10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, bottom: 10, top: 10),
                    child: Messageview(
                      controller: messageController,
                      height: 200,
                      label: "Address",
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Buttonwidget(
                        click: () {
                          if (nameController.text.toString().compareTo("") ==
                              0) {
                            showToast("Please enter name");
                          } else if (selectedcountry == null) {
                            showToast("Please select country");
                          } else if (selecteddistrict == null) {
                            showToast("Please select district");
                          } else {
                            {
                              Map b = {
                                "name": nameController.text.toString(),
                                "email": emailController.text.toString(),
                                "phone": countrycode +
                                    phoneController.text.toString(),
                                // "pancard": pancardController.text.toString(),
                                // "adhaarcard": adharController.text.toString(),
                                "dob": dob,
                                "referalId": agentid,
                                "address": messageController.text.toString(),
                                "nominee_relation":
                                    nominirelationController.text.toString(),
                                "nominee_phone":
                                    nominiphoneController.text.toString(),
                                "nominee": nomininameController.text.toString(),
                                "district": districtid.elementAt(
                                  districts.indexOf(selecteddistrict),
                                ),
                                "branchId": branchid,
                                "adhar": _image == null ? null : _image.path,
                                // "state": stateid
                                //     .elementAt(states.indexOf(selectedstate)),
                                "country": countryid.elementAt(
                                    countrys.indexOf(selectedcountry)),
                                // "pincode": pincodeController.text.toString()
                              };

                              postRegistration(b);
                            }
                            // Navigator.pushNamed(
                            //   context,
                            //   SelectPackage.routeName,
                            // );
                          }
                        },
                        label: "Submit",
                        labelcolors: Colorsapps.buttonTextcolor,
                        height: 50,
                        width: 150,
                        colors: Colorsapps.buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getCountry(int branchid) async {
    print(branchid);
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

  Future<void> getDistrict(String id) async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Districtmodel district = await Locationservice.getDistrict(id);
      EasyLoading.dismiss();
      setState(() {
        districts =
            district.data.districtsList.map((e) => e.districtName).toList();
        districtid = district.data.districtsList.map((e) => e.id).toList();
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

  Future<void> postRegistration(Map details) async {
    try {
      print(details);
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      Agentregisterationmodel data =
          await Registrationservice.getagentRegistration(details);
      EasyLoading.dismiss();

      Navigator.pop(context, true);
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

  // Future<void> getBranch() async {
  //   branch.clear();
  //   branchid.clear();

  //   try {
  //     EasyLoading.show(status: 'Loading...');
  //     //    showLoading(context);
  //     BranchListModel branchs = await Branchservice.getBranch();
  //     EasyLoading.dismiss();
  //     setState(() {
  //       branch = branchs.data.branches.map((e) => e.name).toList();
  //       branchid = branchs.data.branches.map((e) => e.id).toList();
  //     });
  //   } catch (e) {
  //     print(e);
  //     // showErrorMessage(e);
  //     EasyLoading.dismiss();
  //     //  Navigator.pop(context);
  //   }
  // }
}
