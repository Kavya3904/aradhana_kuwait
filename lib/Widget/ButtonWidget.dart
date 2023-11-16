import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Buttonwidget extends StatelessWidget {
  final double width;
  final double height;
  final String colors;
  final String label;
  final String labelcolors;
  final Function click;

  const Buttonwidget({
    Key key,
    this.width,
    this.height,
    this.colors,
    this.label,
    this.click,
    this.labelcolors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: HexColor(colors),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        width: width,
        height: height,
        child: TextButton(
            onPressed: click,
            child: Text(label,
                style: TextStyle(
                    color: HexColor("#000000"), fontWeight: FontWeight.w400))));
  }
}

Widget newButton(String txt, GestureTapCallback onTapp) {
  return InkWell(
    onTap: onTapp,
    child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(txt.toUpperCase(),
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: themeRed)),
  );
}

Widget roundButton(IconData icn, GestureTapCallback onTapp) {
  return GestureDetector(
      onTap: onTapp,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Icon(icn, color: Colors.black),
        decoration: BoxDecoration(
            gradient: goldenUpDownGradient, shape: BoxShape.circle),
      ));
}

Widget newButton2(String txt, GestureTapCallback onTapp) {
  return InkWell(
    onTap: onTapp,
    child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Text(txt.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xffE8C044),
                Color(0xff9A6E2A),
              ],
            ))),
  );
}

Widget newButton40(String txt, GestureTapCallback onTapp) {
  return InkWell(
    onTap: onTapp,
    child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Text(txt.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xffE8C044),
                Color(0xff9A6E2A),
              ],
            ))),
  );
}
