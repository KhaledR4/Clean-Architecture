
import 'package:fitness/constants/ApiEndpoints/api_endpoints.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/data/models/user/gym_user.dart';
import 'package:fitness/core/data/models/user/person_user.dart';
import 'package:fitness/core/data/models/user/trainer_user.dart';
import 'package:get/get.dart';

abstract class SignUpRequest{
  signup(Map<String, dynamic> data);
}

class SignUpRequestImp implements SignUpRequest{
  final _connect = GetConnect();

  @override
  Future<User?> signup(Map<String, dynamic> data) async {
    final result = await _connect.post(ApiEndpoints.signUp, data);
    if(result.statusCode == 409) return null;
    Map<String, dynamic> userInJson = result.body["user"];
    User user =User.empty();
    switch (userInJson["userType"]){
      case 1: 
        user = GymModel.fromJson(userInJson);
        break;
      case 2: 
        user = TrainerModel.fromJson(userInJson);
        break;
      default: 
        user = PersonModel.fromJson(userInJson);
        break;
    }
    user.setAuthToken(result.body["token"]);
    return user;
  }
}