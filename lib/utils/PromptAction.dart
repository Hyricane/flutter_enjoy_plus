import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PromptAction {
  // 成功提示
  static void sucess(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        webPosition: 'center',
        webBgColor: '#5591af');
  }

  // 失败提示
  static void error(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        webPosition: 'center',
        webBgColor: '#ff0000');
  }

  // 信息提示
  static void info(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        webPosition: 'center',
        webBgColor: '#0000ff');
  }
}
