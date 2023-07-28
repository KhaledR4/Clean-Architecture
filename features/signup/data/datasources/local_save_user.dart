import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalUser{
  Future<bool> saveUser(Map<String, dynamic> data);
}

class LocalUserImp implements LocalUser{
  @override
  Future<bool> saveUser(Map<String, dynamic> data) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', jsonEncode(data));
      return true;
    }catch (e) {
      return false;
    }
  }
}