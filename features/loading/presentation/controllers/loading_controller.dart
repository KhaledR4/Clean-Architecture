import 'package:dartz/dartz.dart';
import 'package:fitness/constants/routes.dart';
import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/core/usecases/usecase.dart';
import 'package:fitness/features/loading/domain/usecases/signin_local_token.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class LoadingController extends GetxController{
  final SigninCase signinCase;
  final UserController userController = sl<UserController>();

  LoadingController({required this.signinCase});

  Future loadUser() async{
    Either<Failure, User> result = await signinCase.trigger(NoParams());
    result.fold(
      (failure)  {
        Get.offAndToNamed(RouteNames.login);
      },
      (user) {
        userController.user.value = user;
        Get.offAndToNamed(RouteNames.home);
      }
    );
  }
}