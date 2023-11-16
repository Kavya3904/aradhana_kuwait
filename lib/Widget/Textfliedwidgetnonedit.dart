import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Textfliedwidgetnonedit extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const Textfliedwidgetnonedit({
    Key key, @required this.label, @required this.edit, @required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
   height: 45,
      child: TextField(
    readOnly: true,
    focusNode: new AlwaysDisabledFocusNode(),
  enableInteractiveSelection: true,
        style: TextStyle(fontSize: 14),
        keyboardType: keyboard,
        controller: edit,
 
        decoration: new InputDecoration(
          hintText: label,
          hintStyle: TextStyle(fontSize: 14), 
        contentPadding: EdgeInsets.only(left: 10,),
        enabledBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(0.0),
        borderSide:  BorderSide(color:HexColor("#CDD4D9") ),

      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(0.0),
        borderSide:  BorderSide(color: Theme.of(context).primaryColor),
      )
      
      ),
        // decoration:  InputDecoration(
        // #CDD4D9
          
        //     border: OutlineInputBorder(
              
        //       borderRadius: const BorderRadius.all(
                
        //         const Radius.circular(50.0),
        //       ),
        //     ),
        //     filled: true,
        //     hintStyle:  TextStyle(color: HexColor("#979797"),fontSize: 13),
        //     hintText: label,
        //     fillColor: Colors.white70),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}