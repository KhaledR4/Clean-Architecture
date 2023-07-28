import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/features/signup/presentation/controllers/signup_controller.dart';
import 'package:fitness/features/signup/presentation/widgets/gym_form.dart';
import 'package:fitness/features/signup/presentation/widgets/initial_form.dart';
import 'package:fitness/features/signup/presentation/widgets/user_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignupController signupController = sl<SignupController>();
  final SignupPageController pageController = sl<SignupPageController>();

  List<Widget> forms = [
    Container(
      key: UniqueKey(),
      child: const InitialForm(),
    ),
    Container(
      key: UniqueKey(),
      child: const UserForm(),
    ),
    Container(
      key: UniqueKey(),
      child: const GymUserForm(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint){
        return Center(
          child: SizedBox(
            width: constraint.maxWidth >= 750 ? Get.width * 0.6 : Get.width, 
            height: Get.height * 0.7,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Text('Signup',
                      style: textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),
                    
                    Expanded(
                      child: 
                      SingleChildScrollView(
                        child: Obx((() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: forms[pageController.currentIndex.value],
                          ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          );
        }
      )
    );
  }
}
