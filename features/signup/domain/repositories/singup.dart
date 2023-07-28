import 'package:fitness/core/domain/entities/user/base_user.dart';


abstract class SignUpRepository {
  Future<User> signup(Map<String, dynamic> data);
}

abstract class LocalSaveUserRepository{
  Future<bool> saveUser(Map<String, dynamic> data);
}