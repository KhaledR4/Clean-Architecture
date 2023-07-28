import 'package:fitness/core/domain/entities/user/base_user.dart';

abstract class SigninUserRepository{
  Future<User> signin();
}