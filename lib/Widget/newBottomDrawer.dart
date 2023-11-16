import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Util/videoPage.dart';
import 'package:aradhana/screens/Aboutus/About.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/PDF/PdfView.dart';
import 'package:aradhana/screens/TermsCondition/terms&cond.dart';
import 'package:aradhana/screens/teams/teams.dart';
import 'package:aradhana/service/logoutservice.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Referralcode/Referral.dart';

Future newDrawerr(context, termss) async {
  String user = "";
  String terms = "";
  String refers = "";
  String phone = "";
  String subscriptionid = "";
  int userid;

  var _user = await getSavedObject("name");
  var _terms = await getSavedObject("terms");
  var _refers = await getSavedObject("refers");
  var _phone = await getSavedObject("phone");
  var _userid = await getSavedObject("userid");
  var _subscriptionid = await getSavedObject("subscription");

  user = _user;
  terms = _terms;
  refers = _refers;
  phone = _phone;
  userid = _userid;
  subscriptionid = _subscriptionid.toString();

  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: appbarClr,
      context: context,
      isScrollControlled: true,
      builder: (context) => Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  h(MediaQuery.of(context).size.height * 0.05),
                  tile(Icons.swap_horiz, "Switch Scheme", () {
                    Navigator.pushReplacementNamed(
                        context, SelectScheme.routeName);
                  }),
                  divvv(),
                  // tile(FontAwesomeIcons.trophy, "Winners", () {
                  //   showToast("Coming Soon!");
                  // }),
                  // divvv(),

                  tile(Icons.share, "Referral Code", () {
                    Navigator.pushNamed(context, Referral.routeName);
                  }),
                  divvv(),
                  tile(FontAwesomeIcons.userFriends, "Management", () {
                    Navigator.pushNamed(context, Teams.routeName);
                  }),
                  divvv(),
                  // tile(CupertinoIcons.person_alt, "Profile", () {}),
                  // divvv(),
                  tile(Icons.info_outline, "About Us", () {
                    Navigator.pushNamed(context, Aboutus.routeName);
                  }),
                  divvv(),
                  // tile(Icons.video_collection_sharp, "How To Use", () {
                  //   Navigator.pushNamed(context, videoPage.routeName);
                  // }),
                  // divvv(),

                  tile(FontAwesomeIcons.bullhorn, "Promoters", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pdfView(),
                      ),
                    );
                  }),
                  // divvv(),
                  // tile(Icons.question_mark, "How To Use", () {
                  //   Navigator.pushNamed(context, videoScreen.routeName);
                  // }),
                  divvv(),
                  tile(Icons.description, "Terms & Conditions", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => termsCondition()),
                    );

                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       title: Text("TERMS & CONDITIONS"),
                    //       titleTextStyle:
                    //           font(15, Colors.black, FontWeight.w500),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20)),
                    //       elevation: 16,
                    //       actionsPadding: EdgeInsets.symmetric(
                    //           vertical: 10, horizontal: 20),
                    //       actions: [
                    //         Buttonwidget(
                    //           click: () {
                    //             Navigator.pop(context);
                    //           },
                    //           label: "Dismiss",
                    //           labelcolors: Colorsapps.buttonTextcolor,
                    //           height: 40,
                    //           width: double.infinity,
                    //           colors: "E8C044",
                    //         )
                    //       ],
                    //       content: Scrollbar(
                    //         child: ListView(
                    //           physics: BouncingScrollPhysics(),
                    //           children: [
                    //             Html(data: termss, shrinkWrap: true),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  }),
                  divvv(),
                  tile(Icons.remove_circle_outline, "Delete Account", () {
                    deleteAccount(context);
                  }),
                  // divvv(),
                  // h(MediaQuery.of(context).size.height * 0.1),
                  Divider(color: Colors.white54),
                  TextButton(
                      onPressed: () {
                        exitApp(context);
                      },
                      child: Text(
                        "LOGOUT",
                        style: font(15, accentClr, FontWeight.w500),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 10),
                  ),
                ],
              ),
            ),
          ]));
}

Widget tile(IconData icon, String txt, GestureTapCallback onTap) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    title: Text(txt.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 13)),
    leading: Icon(icon, color: Colors.white),
    onTap: onTap,
  );
}

Widget divvv() {
  return Divider(color: Colors.white54, endIndent: 40, indent: 40);
}

Future<bool> exitApp(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: inputClr,
          title: Text('Confirm exit?'),
          titleTextStyle: font(15, Colors.black, FontWeight.w500),
          contentTextStyle: font(13, Colors.black, FontWeight.w400),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () async {
                close(context);

                //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text(
                'Yes',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> deleteAccount(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: inputClr,
          title: Text('Confirm delete account?'),
          titleTextStyle: font(15, Colors.black, FontWeight.w500),
          contentTextStyle: font(13, Colors.black, FontWeight.w400),
          content: Text('Are you sure you want to delete this account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () async {
                close(context);
              },
              child: Text(
                'Yes',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

void close(BuildContext context) async {
  try {
    EasyLoading.show(status: 'Loading...');
    await Logoutservice.logoutservice();

    EasyLoading.dismiss();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Dashboardlogin', (Route<dynamic> route) => false);
  } catch (e) {
    // showErrorMessage(e);
    showToast("Failed to logout try again later");
    EasyLoading.dismiss();
    print(e);
    //  Navigator.pop(context);
  }
}
