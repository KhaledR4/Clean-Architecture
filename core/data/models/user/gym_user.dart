import 'package:fitness/core/data/models/user/base_user.dart';

class GymModel extends UserModel{
  GymModel({
    required String name,
    required String email,
    required int userType,
    required String number
  }) : super(userType: userType, name: name, email: email, number: number);

  factory GymModel.fromJson(Map<String, dynamic> data){
    return GymModel(
      name: data["name"],
      email: data["email"],
      userType: data["userType"],
      number: data["number"]
      );
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "userType": userType,
      "number": number,
      "token": tokens["Auth"]
    };
  }
}