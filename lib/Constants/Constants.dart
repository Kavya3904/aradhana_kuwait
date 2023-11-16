import 'package:flutter/material.dart';

const title = "Aradhana Gold Kuwait";
const titleSmall = "Aradhana Gold";
const bgClr = Color(0xfff2e8ec);
const inputClr = Color(0xffe0d6d9);
const appbarClr = Color(0xff141413);
const themeRed = Color(0xff8b0404);
// final secondaryClr = Color(0xff00A951);
// final themeClr = Color(0xffFFF200);
const storeName = "Aradhana Gold Kuwait";
const iconClr = Color(0xffc3a435);
const accentClr = Color(0xfff5e8bb);
const shadow = BoxShadow(
    color: Colors.black12,
    offset: Offset(0.0, 2.0),
    blurRadius: 2.0,
    spreadRadius: 1.0);

h(double h) {
  return SizedBox(height: h);
}

w(double w) {
  return SizedBox(width: w);
}

const rs = "د.ك ";

font(double s, Color clr, FontWeight weight) {
  return TextStyle(
      fontSize: s, color: clr, fontWeight: weight, fontFamily: 'Lato');
}

//-----------------------------------------------------------
const HeadingBig = TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lato',
    color: Colors.white);

const size14_400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: 'Lato');
const size14_400W = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'Lato');
const size14_700 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: 'Lato');
const size14_700W = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato');
const size16_600 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const size15_400W = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.white54,
    fontFamily: 'Lato');
const size16_400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: 'Lato');
const size24_800 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: 'Lato');
const size20_700 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: 'Lato');

const size15_800W = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    fontFamily: 'Lato');
const size15_800 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    fontFamily: 'Lato');
const appBarTxtStyl = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato');
const appBarTxtStylB = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: 'Lato');
const size12_400 =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Lato');
const size12_400W = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Lato',
    color: Colors.white);

const size12_600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: 'Lato',
    color: Colors.black);

const goldenUpDownGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xfff3dc96), Color(0xffbb9651)]);

const goldenGradientLeftRight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xfff6d776), Color(0xfffcf5df)]);

const gradientWallet = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xfffdeed8), Color(0xfffab34a)]);

const div = Divider(color: Colors.black12, thickness: 10);
final goldrateText = font(16, Colors.black, FontWeight.w500);
const smallHeading = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: 'Lato');

size(double s) {
  return TextStyle(fontSize: s);
}

String tagLine =
    "We engrave passion with precision to bring out classy designs by blending tradition with style";

int iosUser = 4;

const cfAppID = "TEST41969640ef95ae0e977247b362696914";
const cfSecretKey = "TESTf53bd51f9e7555d92ab00cb8abd78307b6497bf9";

// final razorpayKey = "rzp_test_8ciCCV9XHYGG3d";
const razorpayKey = "rzp_test_8ciCCV9XHYGG3d";
const razorpaySecretKey = "X32b44DlCB4KR1DcVqsQ5rFm";

const razorpayKeyLive = "rzp_live_fp4Ry19zsQwyMB";
const razorpaySecretKeyLive = "voNVHFMShcd39uIfdFF3cRqf";
