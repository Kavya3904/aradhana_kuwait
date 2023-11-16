import 'dart:async';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/homescreen/agentdashboard.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/screens/HomeScreen/Dashboardlogin.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splashscreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    notitficationPermission();
    initMessaging();
    startTime();
    super.initState();
  }

  void getToken() async {
    print("``````````````````````");
    print(await messaging.getToken());
    print("``````````````````````");
    await messaging.subscribeToTopic('sendmeNotification');
  }

  // @override
  // initState() {
  //   startTime();
  //   super.initState();

  //   // FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   // NotificationSettings settings = await messaging.requestPermission(
  //   //   alert: true,
  //   //   announcement: false,
  //   //   badge: true,
  //   //   carPlay: false,
  //   //   criticalAlert: false,
  //   //   provisional: false,
  //   //   sound: true,
  //   // );

  //   // print('User granted permission: ${settings.authorizationStatus}');

  //   // String token = await messaging.getToken();
  //   // print(token);
  // }

  void navigationPage() async {
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     Home.routeName, (Route<dynamic> route) => false);
    int role = await getSavedObject("roleid");
    int subscription = await getSavedObject("subscription");
    if (role != null) {
      if (role == 2 || role == 4) {
        if (subscription != null) {
          //  Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
          Navigator.of(context).pushReplacementNamed(HomeTabs.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(SelectScheme.routeName);
        }
      } else if (role == 3) {
        Navigator.of(context)
            .pushReplacementNamed(AgentDashboardhome.routeName);
      }
    } else {
      // Navigator.of(context).pushReplacementNamed(Login.routeName);
      Navigator.of(context).pushReplacementNamed(Dashboardlogin.routeName);
      // Navigator.of(context).pushReplacementNamed(SplashScreen2.routeName);
    }
// args = ModalRoute.of(context).settings.arguments;
    //  Navigator.pushNamed(
    //                         context,
    //                         Enquiries.routeName,
    //                       );

    // var user = await getSavedObject("@user");

    // if (user != null) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       Home.routeName, (Route<dynamic> route) => false);
    // } else {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       LoginLanding.routeName, (Route<dynamic> route) => false);
    // }
  }

  startTime() async {
    var tkkk = await getSavedObject('token');
    print("``````````````````````");

    print(tkkk);
    print("``````````````````````");

    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png',
                        // color: accentClr,
                        width: MediaQuery.of(context).size.width * 0.8),
                    h(10),
                    Text(
                      "KUWAIT",
                      style: font(20, Color(0xff8b0404), FontWeight.w600),
                    )
                  ],
                )),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: 100,
              right: 100,
              child: SpinKitFadingCube(color: themeRed, size: 25),
            )
          ],
        ),
      ),
    );
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification();
    });
  }

  void showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      'channelName',
    );

    var iosDetails = IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await fltNotification.show(0, 'title', 'body', generalNotificationDetails,
        payload: 'Notification');
  }

  void notitficationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
