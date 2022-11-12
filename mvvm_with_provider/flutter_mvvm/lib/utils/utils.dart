// ignore_for_file: prefer_const_constructors

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMeassage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static flushbarErrorMessage(BuildContext context, String message) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        title: "title",
        duration: Duration(seconds: 3),
        //flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackbar(context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 19),
        ),
      ),
    );
  }
}
