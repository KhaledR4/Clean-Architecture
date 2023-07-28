import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  Rx<User> user = Rx<User>(User.empty());
}