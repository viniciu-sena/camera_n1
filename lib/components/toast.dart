import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(String message, String type) {
  Color backgroundColor = Colors.red;
  Color textColor = Colors.white;
  if (type == 'success') {
    backgroundColor = Colors.green;
  } else if (type == 'warning') {
    backgroundColor = Colors.yellow;
  } else if (type == 'info') {
    backgroundColor = Colors.blue;
  }
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}