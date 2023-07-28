import 'package:fitness/features/login/presentation/widgets/login_form.dart';
import 'package:fitness/widgets/common/texts/signup_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    Text('Login',
                      style: textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),
                    
                    const Expanded(
                      child: 
                      SingleChildScrollView(
                        child: LoginForm(),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    const SignUpText(),
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