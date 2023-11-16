import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/textCapitalization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Textfliedwidget extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const Textfliedwidget({
    Key key,
    @required this.label,
    @required this.edit,
    @required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextField(
        style: font(15, Colors.white, FontWeight.w500),
        keyboardType: keyboard,
        controller: edit,
        cursorColor: Colors.white,
        decoration: new InputDecoration(
          filled: false,
          labelText: label,
          labelStyle: font(12, Colors.white54, FontWeight.w400),
          contentPadding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.white54)),
        ),
      ),
    );
  }
}

class TextfliedwidgetBlack extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const TextfliedwidgetBlack({
    Key key,
    @required this.label,
    @required this.edit,
    @required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextField(
        style: font(15, Colors.black, FontWeight.w500),
        keyboardType: keyboard,
        controller: edit,
        cursorColor: Colors.black,
        decoration: new InputDecoration(
          filled: false,
          labelText: label,
          labelStyle: font(12, Colors.black, FontWeight.w400),
          contentPadding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.black26)),
          focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.black54)),
        ),
      ),
    );
  }
}

class CapsTextfliedwidgetBlack extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const CapsTextfliedwidgetBlack({
    Key key,
    @required this.label,
    @required this.edit,
    @required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextField(
        style: font(15, Colors.black, FontWeight.w500),
        keyboardType: keyboard,
        inputFormatters: [UpperCaseTextFormatter()],
        controller: edit,
        cursorColor: Colors.black,
        decoration: new InputDecoration(
          filled: false,
          labelText: label,
          labelStyle: font(12, Colors.black, FontWeight.w400),
          contentPadding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.black26)),
          focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
              borderSide: new BorderSide(color: Colors.black54)),
        ),
      ),
    );
  }
}

class Textfliedwidget_Fixed extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const Textfliedwidget_Fixed({
    Key key,
    @required this.label,
    @required this.edit,
    @required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 14, color: HexColor("#262626")),
      keyboardType: keyboard,
      controller: edit,
      enabled: false,
      decoration: new InputDecoration(
          hintText: label,
          hintStyle:
              TextStyle(fontSize: 14, color: Color.fromRGBO(141, 142, 141, 1)),
          contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color.fromRGBO(173, 172, 171, 1)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color.fromRGBO(173, 172, 171, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color.fromRGBO(173, 172, 171, 1)),
          )),
    );
  }
}
