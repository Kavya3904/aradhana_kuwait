import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/HomeDrawer.dart';
import 'package:aradhana/screens/HomeScreen/Dashboard.dart';
import 'package:aradhana/screens/MyPackage/Paymentdetailswidget.dart';
import 'package:aradhana/screens/Profile/Profile.dart';
import 'package:aradhana/screens/Wallet/Wallet.dart';
import 'package:aradhana/screens/offers/offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeTabs extends StatefulWidget {
  final id;
  HomeTabs({Key key, this.id}) : super(key: key);
  static String routeName = "/homeTabs";

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int _selectedIndex = 0;
  int role;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  static openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  Future<int> load() async {
    role = await getSavedObject("roleid");
    return role;
    // setState(() {
    //   loading = true;
    // });
    // Timer(Duration(seconds: 4), () {
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final bool _isVisible = true;
  bool loading = false;

  final List<Widget> _widgetOptionsuser = <Widget>[
    const Dashboard(),
    const Paymentdetailswidget(),
    Wallet(),
    const Offers(),
    Profile()
  ];
  final List<Widget> _widgetOptionsuserAgent = <Widget>[
    const Dashboard(),
    const Paymentdetailswidget(),
    Wallet(),
    // Offers(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //  load();
  }

  @override
  Widget build(BuildContext context) {
//   onWillPop: () async {

//      int role = await getSavedObject("roleid");
//     print('Backbutton pressed (device or appbar button), do whatever you want.');

//     //trigger leaving and use own data
//     Navigator.pop(context, false);
// if(role==3)
// {
// Navigator.pop(context, false);
// }else{
//   Navigator.pop(context, false);
//        // Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
// }
//     //we need to return a future
//     return Future.value(false);
//   },

    return
        //  WillPopScope(
        // onWillPop: () async {
        //   int role = await getSavedObject("roleid");
        //   print(
        //       'Backbutton pressed (device or appbar button), do whatever you want.');

        //   //trigger leaving and use own data
        //   // Navigator.pop(context, false);
        //   if (role == 3) {
        //     Navigator.pop(context, false);
        //   } else {
        //                  Navigator.of(context).pushReplacementNamed(HomeTabs.routeName);
        //    // Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        //   }
        //   //we need to return a future
        //   return Future.value(false);
        // },
        // child:

        FutureBuilder<int>(
            future: load(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return WillPopScope(
                  onWillPop: _onBackPressed,
                  child: Scaffold(
                    backgroundColor: bgClr,
                    drawerEdgeDragWidth: 0,
                    key: _scaffoldKey,
                    drawer: const HomeDrawer(),
                    appBar: null,
                    //  drawer: HomeDrawer(),
                    body: Container(
                        child: role == 2 || role == 4
                            ? _widgetOptionsuser.elementAt(_selectedIndex)
                            : _widgetOptionsuserAgent
                                .elementAt(_selectedIndex)),
                    bottomNavigationBar: Offstage(
                      offstage: !_isVisible,
                      child: role == 2 || role == 4
                          ? BottomNavigationBar(
                              backgroundColor: appbarClr,
                              type: BottomNavigationBarType.fixed,
                              showUnselectedLabels: true,
                              selectedLabelStyle: font(
                                  11, const Color(0xffE8C044), FontWeight.w900),
                              unselectedLabelStyle: font(
                                  10, const Color(0xffA9A9A9), FontWeight.w500),
                              selectedItemColor: HexColor("#E8C044"),
                              unselectedItemColor: HexColor("#A9A9A9"),
                              items: <BottomNavigationBarItem>[
                                const BottomNavigationBarItem(
                                    icon: FaIcon(Icons.home_outlined),
                                    activeIcon: FaIcon(Icons.home),
                                    label: 'HOME'),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(CupertinoIcons.briefcase),
                                  activeIcon:
                                      FaIcon(CupertinoIcons.briefcase_fill),
                                  label: 'MY PACKAGE',
                                ),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(
                                      Icons.account_balance_wallet_outlined),
                                  activeIcon:
                                      FaIcon(Icons.account_balance_wallet),
                                  label: 'WALLET',
                                ),
                                const BottomNavigationBarItem(
                                    icon: Icon(CupertinoIcons.gift),
                                    activeIcon: Icon(CupertinoIcons.gift_fill),
                                    label: 'COMMUNITY'),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(Icons.person_outline),
                                  activeIcon: FaIcon(Icons.person),
                                  label: 'PROFILE',
                                ),
                              ],
                              currentIndex: _selectedIndex,
                              onTap: _onItemTapped,
                            )
                          : BottomNavigationBar(
                              backgroundColor: appbarClr,
                              type: BottomNavigationBarType.fixed,
                              showUnselectedLabels: true,
                              selectedLabelStyle: font(
                                  11, const Color(0xffE8C044), FontWeight.w900),
                              unselectedLabelStyle: font(
                                  10, const Color(0xffA9A9A9), FontWeight.w500),
                              selectedItemColor: HexColor("#E8C044"),
                              unselectedItemColor: HexColor("#A9A9A9"),
                              items: <BottomNavigationBarItem>[
                                const BottomNavigationBarItem(
                                    icon: FaIcon(Icons.home_outlined),
                                    activeIcon: FaIcon(Icons.home),
                                    label: 'HOME'),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(CupertinoIcons.briefcase),
                                  activeIcon:
                                      FaIcon(CupertinoIcons.briefcase_fill),
                                  label: 'MY PACKAGE',
                                ),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(
                                      Icons.account_balance_wallet_outlined),
                                  activeIcon:
                                      FaIcon(Icons.account_balance_wallet),
                                  label: 'WALLET',
                                ),
                                const BottomNavigationBarItem(
                                  icon: FaIcon(Icons.person_outline),
                                  activeIcon: FaIcon(Icons.person),
                                  label: 'PROFILE',
                                ),
                              ],
                              currentIndex: _selectedIndex,
                              onTap: _onItemTapped,
                            ),
                    ),
                  ),
                );
              }
              return Container();
            });
    // );
  }

  Future<bool> _onBackPressed() {
    HapticFeedback.mediumImpact();
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      _showDialog();
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: const Text('Confirm Exit!'),
        titleTextStyle: const TextStyle(
            fontSize: 16,
            letterSpacing: 0.6,
            color: Color(0xff333333),
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        content: Text('Are you sure you want to exit?',
            style: font(14, Colors.black, FontWeight.w400)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
