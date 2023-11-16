import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/model/SchemeListModel.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/PriceSelecttab.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/yearlyscheme.dart';
import 'package:aradhana/service/Schemelistservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Selectpackagefirsttime extends StatefulWidget {
  static String routeName = "/Selectpackagefirsttime";
  @override
  _SelectpackagefirsttimeState createState() => _SelectpackagefirsttimeState();
}

class _SelectpackagefirsttimeState extends State<Selectpackagefirsttime> {
  SchemeListmodel data = new SchemeListmodel();

  int schemeid;
  List<int> schemelist = new List();
  List<dynamic> shcemetypelist = new List();
  var _isCheckeded;
  bool backkey = true;
  SchemeList details;
  int shcemetype;
  int role;
  getrole() async {
    role = await getSavedObject("roleid");
  }

  @override
  void initState() {
    super.initState();
    getrole();
    getScheme();
  }

  tick(int index) {
    setState(() {
      _isCheckeded.clear();
      _isCheckeded =
          List<bool>.filled(data.data.schemeList.length, false, growable: true);
      _isCheckeded.remove(index);
      _isCheckeded.insert(index, true);
      schemeid = schemelist.elementAt(index);
      shcemetype = shcemetypelist.elementAt(index);
      print("Scheme id" + schemeid.toString());
    });
  }

  Future<void> getScheme() async {
    try {
      print("reached packaged");
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      SchemeListmodel datas = await Schemelistservice.getScheme();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        EasyLoading.dismiss();
        data = datas;
        print(data);
        //  test();
      });
      _isCheckeded =
          List<bool>.filled(data.data.schemeList.length, false, growable: true);
      data.data.schemeList.forEach((element) {
        schemelist.add(element.id);
        shcemetypelist.add(element.schemeType);
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 18)),
        title: Text(
          "Select Package",
          style: font(13, Colors.white, FontWeight.w600),
        ),
      ),
      backgroundColor: bgClr,
      body: data.data != null
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.data.schemeList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return role == 2 || role == 4
                            ? index == 2
                                ? Opacity(opacity: 0)
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index / 3 == 0
                                              ? HexColor("#E3FBFF")
                                              : index / 3 == 1
                                                  ? HexColor("#FFE3E3")
                                                  : HexColor("#FFFCE3"),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: InkWell(
                                        onTap: () {
                                          details = data.data.schemeList
                                              .elementAt(index);
                                          tick(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            children: [
                                              Text(data.data.schemeList
                                                  .elementAt(index)
                                                  .schemeName),
                                              Spacer(),
                                              _isCheckeded.elementAt(index)
                                                  ? IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .checkCircle,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      })
                                                  : IconButton(
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .circle,
                                                          color: Colors.grey),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                            : data.data.schemeList
                                        .elementAt(index)
                                        .schemeType !=
                                    1
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: InkWell(
                                        onTap: () {
                                          details = data.data.schemeList
                                              .elementAt(index);
                                          tick(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            children: [
                                              Text(data.data.schemeList
                                                  .elementAt(index)
                                                  .schemeName),
                                              Spacer(),
                                              _isCheckeded.elementAt(index)
                                                  ? IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .checkCircle,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      })
                                                  : IconButton(
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .circle,
                                                          color: Colors.grey),
                                                      onPressed: () {
                                                        details = data
                                                            .data.schemeList
                                                            .elementAt(index);
                                                        tick(index);
                                                      }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: newButton("Select", () {
                    if (schemeid == null) {
                      showToast("Please select a scheme");
                    } else if (shcemetype == 1) {
                      Navigator.pushNamed(
                          context, SelectpriceTabyearly.routeName,
                          arguments: details);
                      // showToast(shcemetype.toString());
                    } else {
                      Navigator.pushNamed(context, SelectpriceTab.routeName,
                          arguments: schemeid);
                    }
                  }),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20.0),
                //   child: Buttonwidget(
                //     click: () {
                //       if (schemeid == null) {
                //         showToast("Please select a scheme");
                //       } else if (shcemetype == 1) {
                //         Navigator.pushNamed(
                //             context, SelectpriceTabyearly.routeName,
                //             arguments: details);
                //         // showToast(shcemetype.toString());
                //       } else {
                //         Navigator.pushNamed(
                //             context, SelectpriceTab.routeName,
                //             arguments: schemeid);
                //       }
                //     },
                //     label: "Next",
                //     labelcolors: Colorsapps.buttonTextcolor,
                //     height: 50,
                //     width: 150,
                //     colors: Colorsapps.buttonColor,
                //   ),
                // )
                SizedBox(
                  height: 20,
                )
              ],
            )
          : Container(),
    );
  }
}
