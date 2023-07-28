import 'package:fitness/constants/ApiEndpoints/api_endpoints.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/functionalities/jsonToUser.dart';
import 'package:get/get.dart';

abstract class CheckUserToken{
  Future<User?> getUser(String token);
}

class CheckUserTokenImp implements CheckUserToken{
  final _connect = GetConnect();

  @override
  Future<User?> getUser(String token) async{
    final result = await _connect.get(ApiEndpoints.checkTokenValidation(token));
    if(result.statusCode != 200) return null;
    Map<String, dynamic> userInJson = result.body["user"];
    User user = jsonToUser(userInJson);
    user.setAuthToken(result.body["token"]);
    return user;
  }
}