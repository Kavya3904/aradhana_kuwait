import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';

class Messageview extends StatelessWidget {
  const Messageview(
      {Key key,
      @required TextEditingController controller,
      @required String label,
      @required double height})
      : _controller = controller,
        _label = label,
        _heigth = height,
        super(key: key);
  final String _label;
  final TextEditingController _controller;
  final double _heigth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210, // height: _heigth,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200,
              child: TextField(
                controller: _controller,
                cursorColor: Colors.black,
                style: TextStyle(fontSize: 15, color: Colors.black),
                minLines: 10,
                textInputAction: TextInputAction.done,
                maxLines: 15,
                autocorrect: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: bgClr,
                  // hintText: _label,
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 25,
              top: 3,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                color: bgClr,
                child: Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              )),
        ],
      ),
    );
  }
}
