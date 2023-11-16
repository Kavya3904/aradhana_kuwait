import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';

class SubmitTextInput extends StatelessWidget {
  const SubmitTextInput(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.keyboard,
      this.controller,
      this.edit,
      @required @required this.textcolor})
      : super(key: key);
  final String label, hint;
  final Color textcolor;
  final TextInputType keyboard;
  final bool edit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var inputPadding = EdgeInsets.fromLTRB(10.0, 0, 0.0, 7.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          keyboardType: keyboard,
          controller: controller,
          cursorColor: Colors.black,
          enabled: edit,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 13),
          decoration: InputDecoration(
            contentPadding: inputPadding,
            isDense: false,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black12)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black26)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: appbarClr)),
            hintText: hint,
            labelText: label,
            hintStyle: TextStyle(color: Colors.black54),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class newTxtfield extends StatelessWidget {
  const newTxtfield(
      {Key key,
      this.Iconn,
      @required this.keyboard,
      this.controller,
      this.edit,
      @required @required this.textcolor})
      : super(key: key);
  final Color textcolor;
  final IconData Iconn;
  final TextInputType keyboard;
  final bool edit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
      child: TextFormField(
        controller: controller,
        enabled: edit,
        cursorColor: Colors.black,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: edit ? Colors.black : Colors.black54,
            fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(Iconn,
              size: 18, color: edit ? Colors.black : Colors.black54),
          isDense: false,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ),
    );
  }
}
