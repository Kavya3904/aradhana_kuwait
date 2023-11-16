import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/model/Aboutusmodel.dart';
import 'package:aradhana/service/aboutusserice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatefulWidget {
  static String routeName = "/Aboutus";
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  void _launch(String id) async =>
      await canLaunch(id) ? await launch(id) : throw 'Could not launch $id';
  Aboutusmodel data;

  @override
  void initState() {
    getAboutus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title: Text("About Us", style: appBarTxtStyl),
      ),
      body: data == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Container(
                    // width: 100,
                    height: 60,
                    child: Image.asset("assets/logoOnly.png"),
                  ),
                  h(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data: data.data.aboutUs.description,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Text(
                  //   "The name ‘saleena’ which is familiar to the people of Calicut for the past so many years commenced its business in Kerala in the year 1987 at Calicut, the Capital of Malabar. The Proaims jewellery was founded in the year 1987 by Mr.TP Abdul Rahiman(Avarankoya) Mr.TP Abdul Rahiman pioneered the concept the first of its kind in Kerala. Since its commencement the allegiance towards customer revealed its success and growth. The `Proaims` Group has had a track record of sustained growth which has been made possible because of the group’s allegiance to quality and personalized service.Jewellery The group enjoys a tremendous goodwill, thanks to its practices which have the customer as its first priority.Mr.Abdul Nazer son of Abdul Rahiman heads the jewellery now. Now the management is planning for some more branches to be open soon .His vision and experience enrich with the innovative ideas of his sons made these branches to be take a lead position , As part of innovative step, the group expand their business to wedding centre, Auditorium and shopping complexes",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/fixedAssets/globe.png',
                            color: Colors.black),
                        tooltip: 'Closes application',
                        onPressed: () =>
                            _launch("https://aradhanajewellery.com/"),
                      ),

                      IconButton(
                        icon: Image.asset(
                          'assets/fixedAssets/location.png',
                          color: Colors.black,
                        ),
                        tooltip: 'Closes application',
                        onPressed: () =>
                            _launch("https://goo.gl/maps/eUFmVSReE6aEYhbP8"),
                      ),
                      // IconButton(
                      //   icon: FaIcon(
                      //     FontAwesomeIcons.internetExplorer,
                      //     color: HexColor(
                      //       "#2C4DE6",
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     _launch("https://proaims.com/");
                      //   },
                      // ),
                      // IconButton(
                      //   icon: FaIcon(
                      //     FontAwesomeIcons.searchLocation,
                      //     color: HexColor(
                      //       "#FF0000",
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     _launch(
                      //         "http://maps.google.com/maps?&z=15&mrt=yp&t=k&q=11.248734+75.782342");
                      //   },
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "2023 \u00a9 All Rights Reserved " + title,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<Aboutusmodel> getAboutus() async {
    Aboutusmodel datas;
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      datas = await Aboutusservice.getAboutus();
      print("Reached here");
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();

      setState(() {
        data = datas;
      });
      //  totalpayment = data.data.sheduledList.length;
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      return datas;
      //  Navigator.pop(context);
    }
  }
}
