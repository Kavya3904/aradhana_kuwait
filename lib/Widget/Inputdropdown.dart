import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SubmitSelectInputBorder extends StatelessWidget {
  const SubmitSelectInputBorder(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.listvalues,
      @required this.onChanged,
      @required this.dropdownValue})
      : super(key: key);
  final String label, hint;
  final List<String> listvalues;
  final String dropdownValue;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: TextStyle(color: HexColor("#000000")),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.white54)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10, bottom: 10, right: 20),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color.fromRGBO(254, 254, 254, 1),
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        hint,
                        style: TextStyle(fontSize: 14, color: Colors.white54),
                      ),
                      isDense: true,
                      isExpanded: true,
                      elevation: 5,
                      value: dropdownValue,
                      dropdownColor: inputClr,
                      underline: Container(height: 0),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      style: font(15, Colors.white54, FontWeight.w500),
                      onChanged: onChanged,
                      items: listvalues.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitSelectInputBorderBlack extends StatelessWidget {
  const SubmitSelectInputBorderBlack(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.listvalues,
      @required this.onChanged,
      @required this.dropdownValue})
      : super(key: key);
  final String label, hint;
  final List<String> listvalues;
  final String dropdownValue;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25, bottom: 10, top: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black54)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10, bottom: 10, right: 20),
            child: DropdownButton<String>(
              hint: Text(hint,
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              isDense: true,
              isExpanded: true,
              elevation: 2,
              dropdownColor: Colors.white,
              value: dropdownValue,
              underline: Container(height: 0),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: font(15, Colors.black54, FontWeight.w500),
              onChanged: onChanged,
              items: listvalues.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
