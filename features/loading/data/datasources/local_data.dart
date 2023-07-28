import 'dart:convert';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/functionalities/jsonToUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalSource{
  Future<String?> getUserToken();
  Future<User?> getUser();
}

class UserLocalSourceImp implements UserLocalSource{
  @override
  Future<String?> getUserToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('user')) return null; // no user is saved locally
    return Map.from(jsonDecode(prefs.getString('user')!))['auth'];
  }

  @override
  Future<User?> getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('user')) return null; // no user is saved locally
    Map<String, dynamic> localUserData = Map.from(jsonDecode(prefs.getString('user')!));
    User user = jsonToUser(localUserData);
    user.setAuthToken(localUserData["auth"]);
    user.setFirebaseId(localUserData["firebaseId"]);
    return user;
  }
}