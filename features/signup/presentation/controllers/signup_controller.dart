import 'package:dartz/dartz.dart';
import 'package:fitness/constants/routes.dart';
import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/dateTime/date.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/signup/domain/usecases/signup_usecase.dart';
import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/widgets/notifiers/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class SignupController extends GetxController{
  final SignupCase signupCase;
  final List<String> genderChoices = ['Male', 'Female'];
  final List<String> userChoices = ['Person', 'Trainer', 'Gym'];

  final firstFormKey = GlobalKey<FormState>();
  final userFormKey = GlobalKey<FormState>();
  final gymFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController secondPassController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController gymNameController = TextEditingController();
  RxString year = RxString(DateTime.now().year.toString());
  RxString month = RxString("January");
  RxString day = RxString("1");
  RxString gender = RxString("Male");
  RxString userType = RxString('Person');
  RxString emailError = RxString("");

  final SignupPageController mainPageController = sl<SignupPageController>();
  final UserController userController = sl<UserController>();

  SignupController({
    required this.signupCase
  });


  void validateFirstForm(){
    if(firstFormKey.currentState!.validate()){
      if(isGym()) {
        mainPageController.goToGymForm();
        return;
      }
      mainPageController.goToUserForm();
    }
  }

  bool secondFormValidated(){
    if(isGym()) return gymFormKey.currentState!.validate();
    return userFormKey.currentState!.validate();
  }

  void submitForm() async {
    if(mainPageController.loading.value) return;
    if(!secondFormValidated()) return; // second form has still wrongdata

    mainPageController.setLoading();
    mainPageController.goToInitialForm();
    Map<String, dynamic> data = formDataToJson();
    Either<Failure, User> result = await signupCase.trigger(data);
    mainPageController.stopLoading();
    
    result.fold(
      (failure)  {
        if(failure is NetworkFailure) Toast.networkErrorToast();
        if(failure is ServerFailure) Toast.serverErrorToast();
        if(failure is CacheFailure) Toast.serverErrorToast();
        if(failure is DataFormFailure) {
          emailError.value = "Email is already registered";
          firstFormKey.currentState!.validate();
        }
      },
      (user) {
        userController.user.value = user;
        Get.offAndToNamed(RouteNames.home);
      }
    );

  }

  String? isEmailErrorNull(){
    if(emailError.value.isEmpty) return null;
    return emailError.value;
  }

  bool isPerson(){
    return userType.value == 'Person';
  }

  bool isTrainer(){
    return userType.value == 'Trainer';
  }

  bool isGym(){
    return userType.value == 'Gym';
  }

  int userTypeToInt(){
    if(isGym()) return 1;
    if(isTrainer()) return 2;
    return 3;
  }

  Map<String, dynamic> formDataToJson(){
    if(isGym()) return gymDataToJson();
    return userDataToJson();
  }

  Map<String, dynamic> gymDataToJson(){
    return {
      "name": gymNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "number": numberController.text,
      "userType": userTypeToInt(), 
    };
  }

  Map<String, dynamic> userDataToJson(){
    return {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "number": numberController.text,
      "isMale": gender.value == "Male",
      "birthday": Date(year: year.value, month: month.value, day: day.value).formatDate(),
      "userType": userTypeToInt(),
    };
  }
}