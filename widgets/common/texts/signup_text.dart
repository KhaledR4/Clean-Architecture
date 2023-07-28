import 'package:fitness/constants/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an Account? ",
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: "Sign up.",
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(RouteNames.signup);
              },
          ),
        ],
      ),
    );
  }
}