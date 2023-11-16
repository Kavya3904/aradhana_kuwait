import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/Agentprofile/agentprofile.dart';
import 'package:aradhana/Screenagent/Paymentdetails/Pendingpaymentdetials.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/exitwidget.dart';
import 'package:aradhana/screens/Aboutus/About.dart';
import 'package:aradhana/screens/Referralcode/Referral.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgentDrawer extends StatefulWidget {
  @override
  _AgentDrawerState createState() => _AgentDrawerState();
}

class _AgentDrawerState extends State<AgentDrawer> {
  String user = "";
//  String terms = "";
  // String refers = "";

  getUser() async {
    var _user = await getSavedObject("name");
    //  var _terms = await getSavedObject("terms");
    //  var _refers = await getSavedObject("refers");

    setState(() {
      user = _user == null ? "" : _user;
      //  terms = _terms;
      // refers = _refers;
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
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());

    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: appbarClr,

          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/whitebg.png"),
          //     fit: BoxFit.fill,
          //   ),
          // ),
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
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(),
                  ),
                ),
              ),

              Divider(color: Colors.white, thickness: 1.5),
              tile("Profile", Icons.person, () {
                Navigator.pushNamed(
                  context,
                  Agentprofile.routeName,
                );
              }),
              divvv(),
              tile("Pending Payments", FontAwesomeIcons.rupeeSign, () {
                Navigator.pushNamed(
                  context,
                  PendingPayment.routeName,
                );
              }),
              divvv(),
              tile("Referral Code", Icons.share, () {
                Navigator.pushNamed(context, Referral.routeName);
              }),
              divvv(),
              tile("About Us", Icons.info_outline, () {
                Navigator.pushNamed(context, Aboutus.routeName);
              }),
              divvv(),

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
              tile("Logout", Icons.logout, () {
                exitApp(context);
              }),
              divvv(),

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
    );
  }

  Widget tile(String txt, IconData icn, GestureTapCallback onTapp) {
    return ListTile(
        title: Text(txt,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: Icon(icn, color: accentClr),
        onTap: onTapp);
  }

  Widget divvv() {
    return Divider(color: Colors.white54, endIndent: 40, indent: 40);
  }
}
