import 'package:fitness/core/validation/inputValidation.dart';
import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/features/signup/presentation/controllers/signup_controller.dart';
import 'package:fitness/widgets/common/loading/cirular_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymUserForm extends StatefulWidget {
  const GymUserForm({super.key});

  @override
  State<GymUserForm> createState() => _GymUserFormState();
}

class _GymUserFormState extends State<GymUserForm> {
  final SignupController signupController = sl<SignupController>();
  final SignupPageController pageController = sl<SignupPageController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupController.gymFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: signupController.gymNameController,
            decoration: const InputDecoration(labelText: 'Gym Name'),
            validator: (value) {
              return checkNull(signupController.gymNameController);
            },
          ),
           Obx(() => ElevatedButton(
                      onPressed: signupController.submitForm,
                      child: pageController.loading.value ? loadingWidget(): 
                const Text('Submit'),
                    ),
                  )
        ],)
    );
  }
}