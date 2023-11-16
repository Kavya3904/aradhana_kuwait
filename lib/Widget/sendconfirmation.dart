

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
  Future<bool> sendConfirmation(BuildContext context) 
  {
    return showDialog(
          context: context,
  builder: (context) => AlertDialog(
            title: Text('Payment'),
            content: Text('Pay for this customer ...'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
await preferences.clear();
Navigator.of(context)
    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

               //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }