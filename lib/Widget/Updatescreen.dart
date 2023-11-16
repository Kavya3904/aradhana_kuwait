import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Update extends StatefulWidget {
  static String routeName = "/Update";
  Update({
    Key key,
  }) : super(key: key);

  @override
  _NewOtpState createState() => _NewOtpState();
}

class _NewOtpState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fixedAssets/whitebg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
              child: Container(
            width: 300,
            height: 200,
            child: Card(
              elevation: 20,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A new version of app is available in play store, please update to continue using the app",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        await FirebaseAuth.instance.signOut();
                        if (Platform.isAndroid) {
                          launch(
                              "https://play.google.com/store/apps/details?id=com.goldscheme.aradhanakuwait");
                        } else {
                          launch(
                              "https://apps.apple.com/in/app/aradhana-jewellery/id6449661095");
                        }
//            try
//             {
//   launch("market://details?id=" + "com.lulu.goldscheme");
// } on PlatformException catch(e)
// {
//   launch("https://play.google.com/store/apps/details?id=" + "com.lulu.goldscheme");
// } finally {
//   launch("https://play.google.com/store/apps/details?id=" + "com.lulu.goldscheme");
// }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )),
            ),
          )),
        ),
      ),
    );
  }
}
