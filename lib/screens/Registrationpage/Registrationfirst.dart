import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/Widget/TextfliedWidget.dart';
import 'package:aradhana/screens/Registrationpage/Registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Registration extends StatefulWidget {
  static String routeName = "/Registration";
  const Registration({key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();

  String mobilenumber;
  String selecteddistrict;
  String dob;

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
        dateofbirthcontroller.text =
            DateFormat('dd  MMM, yyyy').format(DateTime.parse(dob)).toString();
      });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        mobilenumber = ModalRoute.of(context).settings.arguments;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ss = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ss.height * 0.05),
        child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white),
      ),
      body: Column(
        children: [
          Text("Welcome", style: font(14, Colors.black54, FontWeight.w400)),
          h(ss.height * 0.01),
          Text("Create an account",
              style: font(15, Colors.black, FontWeight.w500)),
          // h(ss.height * 0.03),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Image.asset(
                  //
                  //     fit: BoxFit.cover,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  Container(
                    decoration: new BoxDecoration(
                        color: const Color(0xfff2e8ec),
                        borderRadius: new BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CapsTextfliedwidgetBlack(
                                edit: nameController,
                                label: "Name",
                                keyboard: TextInputType.name,
                              ),
                              TextfliedwidgetBlack(
                                  edit: emailController,
                                  label: "Email",
                                  keyboard: TextInputType.emailAddress),
                              h(10),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, bottom: 0),
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: HexColor("#262626")),
                                    decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: const Icon(
                                            Icons.calendar_month,
                                            size: 18),
                                        fillColor: const Color(0xfff2e8ec),
                                        enabled: false,
                                        hintText: "Date Of Birth",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: HexColor("#262626")),
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, top: 5, bottom: 5),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black26),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black26),
                                        )),
                                    controller: dateofbirthcontroller,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              newButton("Next", () {
                                if (nameController.text
                                        .toString()
                                        .compareTo("") ==
                                    0) {
                                  showToast("Please enter name");
                                } else {
                                  Map details = {
                                    "name": nameController.text.toString(),
                                    "date": dob,
                                    "mobile": mobilenumber,
                                    "email": emailController.text.toString()
                                  };

                                  Navigator.pushNamed(
                                      context, Registerationsecond.routeName,
                                      arguments: details);
                                }
                              }),
                              // roundButton(Icons.arrow_forward, () {
                              //   if (nameController.text
                              //           .toString()
                              //           .compareTo("") ==
                              //       0) {
                              //     showToast("Please enter name");
                              //   } else {
                              //     Map details = {
                              //       "name": nameController.text.toString(),
                              //       "date": dob,
                              //       "mobile": mobilenumber,
                              //       "email": emailController.text.toString()
                              //     };
                              //
                              //     Navigator.pushNamed(
                              //         context, Registerationsecond.routeName,
                              //         arguments: details);
                              //   }
                              // }),
                            ],
                          ),
                        ),
                      ],
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
}
