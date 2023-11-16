import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/screens/HomeScreen/Dashboardlogin.dart';
import 'package:flutter/material.dart';

class SplashScreen2 extends StatefulWidget {
  static String routeName = "/splash2";
  const SplashScreen2({Key key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset("assets/logo.png"),
        h(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Text(tagLine,
              style: font(16, Colors.white70, FontWeight.w400),
              textAlign: TextAlign.center),
        )
      ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, bottom: 40),
        child: newButton("NEXT", () {
          Navigator.of(context).pushReplacementNamed(Dashboardlogin.routeName);
        }),
      ),
    );
  }
}
