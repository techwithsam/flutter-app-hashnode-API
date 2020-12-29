import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashnode/theme/colors.dart';

class CustomFunction {
  showToast({dynamic message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor().mainColor,
        textColor: Colors.white,
        fontSize: 14);
  }

  Future<int> checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return 0;
    } else if (result == ConnectivityResult.mobile) {
      return 1;
    } else if (result == ConnectivityResult.wifi) {
      return 1;
    } else {
      return 0;
    }
  }
}
