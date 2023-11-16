import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/service/logoutservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> exitApp(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: inputClr,
          title: Text('Confirm exit?'),
          titleTextStyle: font(15, Colors.black, FontWeight.w500),
          contentTextStyle: font(13, Colors.black, FontWeight.w400),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () async {
                close(context);

                //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text(
                'Yes',
                style: font(13, Colors.black, FontWeight.w500),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> deleleData(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'This will delete your account and remove all data. Are you sure u want to continue ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                deleteAccount(context);

                //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}

void close(BuildContext context) async {
  try {
    EasyLoading.show(status: 'Loading...');
    await Logoutservice.logoutservice();

    EasyLoading.dismiss();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Dashboardlogin', (Route<dynamic> route) => false);
  } catch (e) {
    // showErrorMessage(e);
    showToast("Failed to logout try again later");
    EasyLoading.dismiss();
    print(e);
    //  Navigator.pop(context);
  }
}

void deleteAccount(BuildContext context) async {
  try {
    EasyLoading.show(status: 'Loading...');
    await Logoutservice.deleteService();

    EasyLoading.dismiss();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Dashboardlogin', (Route<dynamic> route) => false);
  } catch (e) {
    // showErrorMessage(e);
    showToast("Failed to delete try again later");
    EasyLoading.dismiss();
    print(e);
    //  Navigator.pop(context);
  }
}
