import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';

class choosepaymentOption extends StatefulWidget {
  static String routeName = "/choosepaymentOption";

  const choosepaymentOption({Key key}) : super(key: key);

  @override
  State<choosepaymentOption> createState() => _choosepaymentOptionState();
}

class _choosepaymentOptionState extends State<choosepaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose payment mode", style: appBarTxtStyl),
      ),
    );
  }
}
