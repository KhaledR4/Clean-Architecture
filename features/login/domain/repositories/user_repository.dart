import 'package:fitness/core/domain/entities/user/base_user.dart';

abstract class LoginRepository{
  Future<User> signin(String email, String password);
}