import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo{
  static Future<bool> isConnected() async{
    final connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.vpn;
  }
}