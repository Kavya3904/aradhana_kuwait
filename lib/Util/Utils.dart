import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Colorsapps {
  static String buttonTextcolor = "#ffffff";
  static String buttonColor = "#E8C044";
}

saveObject(String key, value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  } catch (e) {
    throw e;
  }
}

// appColors() {
//  final  String buttonColor = "#882173";
//  final  String buttonTextcolor = "#ffffff";
// }

savename(String key, value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  } catch (e) {
    throw e;
  }
}

// savetoken(String key, value) async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, json.encode(value));
//   } catch (e) {
//     throw e;
//   }
// }

getSavedObject(String key) async {
  final prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(key);
  return data != null ? json.decode(prefs.getString(key)) : null;
}

// Future<String> getSessionId() async {
//   var user = await getSavedObject("@user");
//   if (user != null) {
//     UserModel _user = UserModel.fromJson(user);
//     return _user.sessionId;
//   } else {
//     return null;
//   }
// }

// Future<String> getUserId() async {
//   var user = await getSavedObject("@user");
//   if (user != null) {
//     UserModel _user = UserModel.fromJson(user);
//     return _user.userId;
//   } else {
//     return null;
//   }
// }

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

showErrorMessage(error) {
  if (isInDebugMode) {
    print("Error is :" + error.toString());
  }
  if (!error.toString().contains("setState()")) {
    if (error is DioError) {
      DioError e = error;
      var message = e.response.data["message"];
      if (message == null) {
        message = e.response.data["message"];
        if (message == null) {
          message = "Oops Something went wrong try again !!";
        }
      } else {
        message = e.response.data["message"];
      }
      Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: error.toString() ?? "Oops Something went wrong try again !!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

showToastCenter(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
