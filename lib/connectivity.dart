import 'dart:async';
import 'package:connectivity/connectivity.dart';

class checkConnectivity {
  static var connectivityResult;

  static Future<bool> isNetworkReachable() async {
    connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }
}
