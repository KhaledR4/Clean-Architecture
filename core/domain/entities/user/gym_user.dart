import 'dart:math';

import 'package:fitness/core/domain/entities/user/base_user.dart';

class GymUser extends User{
  GymUser({
    required String email,
    required String number,
    required String name,
    required int userType
  }) : super(email: email,
              name: name,
              number: number,
              userType: userType
        );
}