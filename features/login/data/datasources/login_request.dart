import 'package:fitness/constants/ApiEndpoints/api_endpoints.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/functionalities/jsonToUser.dart';
import 'package:get/get.dart';

abstract class LoginRequest{
  Future<User?> signin(String email, String password);
}

class LoginRequestImp implements LoginRequest{
  final _connect = GetConnect();

  @override
  Future<User?> signin(String email, String password) async {
    final result = await _connect.get(ApiEndpoints.checkUserCredentials(email, password));
    if(!result.body["success"]) return null;
    Map<String, dynamic> userInJson = result.body["user"];
    User user = User.empty();
    user = jsonToUser(userInJson);
    user.setAuthToken(result.body["token"]);
    return user;
  }
}