import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';

class SubmitTextInputTextfocus extends StatelessWidget {
  const SubmitTextInputTextfocus(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.keyboard,
      this.controller,
      this.edit,
      this.fcous})
      : super(key: key);
  final String label, hint;
  final FocusNode fcous;
  final TextInputType keyboard;
  final bool edit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var inputPadding = EdgeInsets.fromLTRB(
      2.0,
      0,
      0.0,
      7.0,
    );
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: keyboard,
            controller: controller,
            enabled: edit,
            focusNode: fcous,
            style: TextStyle(fontSize: 14, color: Colors.black),
            decoration: new InputDecoration(
              hintText: label,
              hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
              contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black12)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black54)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: appbarClr)),
            ),
          ),
        ],
      ),
    );
  }
}
