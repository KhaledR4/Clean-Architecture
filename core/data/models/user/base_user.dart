import 'package:fitness/core/domain/entities/user/base_user.dart';

class UserModel extends User{
  UserModel({
    required String name,
    required String email,
    required int userType,
    required String number
  }) : super(userType: userType, name: name, email: email, number: number);

  factory UserModel.fromJson(Map<String, dynamic> data){
    return UserModel(
      name: data["name"],
      email: data["email"],
      userType: data["userType"],
      number: data["number"]
      );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "userType": userType,
      "firebaseId": getFireUserId(),
      "auth": getAuthToken(),
    };
  }
}