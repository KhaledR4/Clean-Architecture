

import 'package:fitness/core/validation/inputValidation.dart';
import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/features/signup/presentation/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class InitialForm extends StatefulWidget {
  const InitialForm({super.key});

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  final SignupController signupController = sl<SignupController>();
  final SignupPageController pageController = sl<SignupPageController>();
  

  @override
  Widget build(BuildContext context) {

    return Form(
      key: signupController.firstFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: signupController.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value){
                    signupController.emailError.value = '';
                  },
                  validator: (value) {
                    List<String? Function()> validators = [() => checkNull(signupController.emailController), () => signupController.isEmailErrorNull()];
                    return checkAllValidators(validators);
                  },
                ),
              ),

              const SizedBox(width: 10,),

              Expanded(
                child: TextFormField(
                  controller: signupController.numberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return checkNull(signupController.numberController);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20,),

          TextFormField(
            controller: signupController.passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) {
              return checkNull(signupController.passwordController);
            },
          ),

          const SizedBox(height: 20,),

          TextFormField(
            controller: signupController.secondPassController,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            validator: (value) {
              List<String? Function()> validators = [() => checkNull(signupController.secondPassController), () => checkPassEquality(signupController.passwordController, signupController.secondPassController)];
              return checkAllValidators(validators);
            },
          ),

          const SizedBox(height: 20,),

          Obx(() => DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Signup As:'),
              value: signupController.userType.value,
              items: signupController.userChoices.map((choice) => 
                DropdownMenuItem(
                  value: choice,
                  child: Text(choice),
                  )
                ).toList(),
               onChanged: (value){
                signupController.userType.value = value!;
               }),
          ),

          const SizedBox(height: 20,),

          SizedBox(
            width: double.infinity,
            child: 
            Obx( () =>
              ElevatedButton(onPressed: () => { 
                signupController.validateFirstForm()}, child: pageController.loading.value ? const CircularProgressIndicator() : Text('Next',)),
            ),
          ),

          const SizedBox(height: 10,),
        ]),
    );
  }
}