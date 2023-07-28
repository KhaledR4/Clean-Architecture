import 'package:fitness/core/data/models/user/base_user.dart';

abstract class FirebaseUserRepository{
  Future<bool> saveUser(Map<String, dynamic> data, String userId);
  Future<List<UserModel>> searchUsers(String email);
}