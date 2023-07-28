import 'package:fitness/core/validation/inputValidation.dart';
import 'package:fitness/features/login/presentation/controllers/login_controller.dart';
import 'package:fitness/widgets/common/loading/cirular_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginController loginController = sl<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: loginController.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
                    List<String? Function()> validators = [() => checkNull(loginController.emailController), () => loginController.isEmailErrorNull()];
                    return checkAllValidators(validators);
                  }
          ),

          const SizedBox(height: 10,),

          TextFormField(
            controller: loginController.passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) {
              return checkNull(loginController.passwordController);
            },
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: 
            Obx( () =>
              ElevatedButton(onPressed: loginController.login, 
              child: loginController.loading.value ? 
                loadingWidget() : 
                const Text('Submit')),
            ),
          ),
        ],
      )
    );
  }
}