import 'package:fitness/core/data/models/user/base_user.dart';

class PersonModel extends UserModel{
  String firstName;
  String lastName;
  bool isMale;
  String birthday;

  PersonModel({
    required String name,
    required String email,
    required int userType,
    required String number,
    required this.firstName,
    required this.lastName,
    required this.isMale,
    required this.birthday,
  }) : super(userType: userType, name: name, email: email, number: number);

  factory PersonModel.fromJson(Map<String, dynamic> data){
    return PersonModel(
      name: "${data['firstName']} ${data['lastName']}",
      email: data["email"],
      userType: data["userType"],
      number: data["number"],
      firstName: data['firstName'],
      lastName: data['lastName'],
      isMale: data["isMale"],
      birthday: data["birthday"],
      );
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "userType": userType,
      "number": number,
      "isMale": isMale,
      "birthday": birthday,
      "token": tokens["Auth"]
    };
  }
}