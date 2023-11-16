 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 class OtpEntryFormState extends StatefulWidget {
  static String routeName = "/otp";

  @override
  _OtpEntryFormStateState createState() => _OtpEntryFormStateState();
}

class _OtpEntryFormStateState extends State<OtpEntryFormState> {
        final _formKey = GlobalKey<FormState>();

        FocusNode node1 = FocusNode();

        FocusNode node2 = FocusNode();

        FocusNode node3 = FocusNode();

        FocusNode node4 = FocusNode();

        String pin1;

        String pin2;

        String pin3;

        String pin4;

        @override
        Widget build(BuildContext context) {
          return Scaffold(
                      body: Column(
              children: <Widget>[
                //Now create a row widget, where we'll be adding our textboxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //TextBox1
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        focusNode: node1,
                        onChanged: (text) {
                          if (text.length == 1) {
                            FocusScope.of(context).requestFocus(node2);
                            pin1 = text;
                          } 
                        },
                        keyboardType: TextInputType.number,
                      )
                    ),

                    //Spacing in-between textbox
                    SizedBox(
                      width: 20
                    ),

                    //TextBox2
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        focusNode: node2,
                        onChanged: (text) {
                          if (text.length == 1) {
                            FocusScope.of(context).requestFocus(node3);
                            pin2 = text;
                          } 
                          else if (text.isEmpty) {
                              FocusScope.of(context).requestFocus(node1);
                            }
                        },
                        keyboardType: TextInputType.number,
                      )
                    ),

                    //Spacing in-between textbox
                    SizedBox(
                      width: 20
                    ),

                    //TextBox3
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                           keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        focusNode: node3,
                        onChanged: (text) {
                          if (text.length == 1) {
                            FocusScope.of(context).requestFocus(node4);
                            pin3 = text;
                          } 
                          else if (text.isEmpty) {
                              FocusScope.of(context).requestFocus(node2);
                            }
                            
                        },
                      )
                    ),

                    //Spacing in-between textbox
                    SizedBox(
                      width: 20
                    ),

                    //TextBox4
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                           keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        focusNode: node4,
                        onChanged: (text) {
                          if (text.length == 1) {
                            FocusScope.of(context).requestFocus(node4);
                            pin4 = text;
                          } 
                          else if (text.isEmpty) {
                              FocusScope.of(context).requestFocus(node3);
                            }
                        },
                      )
                    ), 
                  ],
                ),

                //Spacing Between the textbox row and the submit button
                SizedBox(
                  height: 10,
                ),

                //Submit Button
                SizedBox(
                  width: 30,
                  child: ElevatedButton(

                        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),

               
                  
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        String fullPin = pin1+pin2+pin3+pin4;

                        String combinedPin = fullPin; 

                        int intPin = int.parse(combinedPin);
                        print("OPT Pin: " + intPin.toString());
                      }
                    },
                    child: 
                      Text(
                        'SUBMIT',
                      )
                  ),
                ),
              ],
            ),
          );
        }
}