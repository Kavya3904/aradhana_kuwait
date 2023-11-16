import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/Widget/exitwidget.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/screens/Aboutus/About.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Referralcode/Referral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/teams/teams.dart';

class HomeDrawer extends StatefulWidget {
  final Sheduledmodel data;

  const HomeDrawer({Key key, this.data}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String user = "";
  String terms = "";
  String refers = "";
  String phone = "";
  String subscriptionid = "";
  int userid;

  getUser() async {
    var _user = await getSavedObject("name");
    var _terms = await getSavedObject("terms");
    var _refers = await getSavedObject("refers");
    var _phone = await getSavedObject("phone");
    var _userid = await getSavedObject("userid");
    var _subscriptionid = await getSavedObject("subscription");
    setState(() {
      user = _user;
      terms = _terms;
      refers = _refers;
      phone = _phone;
      userid = _userid;
      subscriptionid = _subscriptionid.toString();
    });
  }

  // final Uri _emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'smith@example.com',
  //     queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});
  //final String _facebookd = "https://www.facebook.com/";

  // final Uri _facebookd = Uri(
  //     scheme: 'mailto',
  //     path: 'smith@example.com',
  //     queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());

    return Drawer(
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/fixedAssets/whitebg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              height: MediaQuery.of(context).size.height < 600
                  ? MediaQuery.of(context).size.height + 70
                  : MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 120,
                      child: DrawerHeader(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Reg No : " + userid.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Scheme No: " +
                                  "Sb-" +
                                  subscriptionid.toString().padLeft(5, '0'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(),
                      ),
                    ),
                  ),

                  Divider(
                    color: Colors.black,
                    thickness: 1.5,
                  ),

                  ListTile(
                    title: Text('Switch Scheme',
                        style: TextStyle(color: Colors.black)),
                    leading: Icon(
                      Icons.switch_account,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SelectScheme.routeName,
                      );
                    },
                  ),

                  ListTile(
                    title: Text('Terms and Conditions',
                        style: TextStyle(color: Colors.black)),
                    leading: Icon(
                      Icons.description,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 16,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      "TERMS AND CONDITIONS",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: HexColor("#000000"),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Html(data: terms),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, right: 35),
                                    child: Buttonwidget(
                                      click: () {
                                        Navigator.pop(context);
                                      },
                                      label: "Dismiss",
                                      labelcolors: Colorsapps.buttonTextcolor,
                                      height: 40,
                                      width: 150,
                                      colors: Colorsapps.buttonColor,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Referral Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.share,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Referral.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Management',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.userFriends,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Teams.routeName);
                    },
                  ),

                  ListTile(
                    title:
                        Text('About US', style: TextStyle(color: Colors.black)),
                    leading: FaIcon(
                      FontAwesomeIcons.addressBook,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Aboutus.routeName);
                    },
                  ),
                  // ListTile(
                  //   title: Text('Finance'),
                  //   leading: FaIcon(
                  //     FontAwesomeIcons.coins,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, InvoiceList.routeName);
                  //   },
                  // ),
                  // ListTile(
                  //   title: Text('My Profile'),
                  //   leading: FaIcon(
                  //     FontAwesomeIcons.user,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),

                  ListTile(
                    title:
                        Text('Logout', style: TextStyle(color: Colors.black)),
                    leading: Icon(
                      Icons.logout,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      exitApp(context);
                    },
                  ),

                  ListTile(
                    title: Text('Delete Account',
                        style: TextStyle(color: Colors.black)),
                    leading: Icon(
                      Icons.remove,
                      color: HexColor("#FFD98D"),
                    ),
                    onTap: () {
                      deleleData(context);
                    },
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Spacer(),

                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
