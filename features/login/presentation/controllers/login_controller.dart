import 'package:dartz/dartz.dart';
import 'package:fitness/constants/routes.dart';
import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/login/domain/usecases/login_usecase.dart';
import 'package:fitness/widgets/notifiers/toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString emailError = RxString("");
  RxBool loading = RxBool(false);

  final UserController userController = sl<UserController>();

  final LoginCase loginCase;

  LoginController({required this.loginCase});

  login() async{
    if(loading.value) return;
    emailError.value = "";
    if(!formKey.currentState!.validate()) return;
    loading.value = true;
    Either<Failure, User> result = await loginCase.trigger(setFormData());
    loading.value = false;

    result.fold(
      (failure)  {
        if(failure is NetworkFailure) Toast.networkErrorToast();
        if(failure is ServerFailure) Toast.serverErrorToast();
        if(failure is DataFormFailure) {
          emailError.value = "Incorrect Credentials";
          formKey.currentState!.validate();
        }
      },
      (user) {
        userController.user.value = user;
        Get.offAndToNamed(RouteNames.home);
      }
    );
  }

  Map<String, String> setFormData(){
    return {
      "email": emailController.text,
      "password": passwordController.text
    };
  }

  String? isEmailErrorNull(){
    if(emailError.value.isEmpty) return null;
    return emailError.value;
  }


}