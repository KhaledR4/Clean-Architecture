import 'package:fitness/core/domain/entities/user/base_user.dart';

class Person extends User{
  String firstName;
  String lastName;
  bool isMale;
  String birthday;
  
  Person({
    required String email,
    required String number,
    required String name,
    required int userType,
    required this.firstName,
    required this.lastName,
    required this.isMale,
    required this.birthday,
  }) : super(email: email,
              name: name,
              number: number,
              userType: userType
            );
}