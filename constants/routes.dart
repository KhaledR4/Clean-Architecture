import 'package:fitness/features/chatSection/presentation/pages/home_page.dart';
import 'package:fitness/features/loading/presentation/pages/main.dart';
import 'package:fitness/features/login/presentation/pages/main.dart';
import 'package:fitness/features/messagesSection/presentation/pages/main.dart';
import 'package:fitness/features/signup/presentation/pages/main.dart';
import 'package:get/get.dart';

class RouteNames{
  static const String initial = '/';
  static const String login = "/login";
  static const String signup = '/signup';
  static const String home = '/home';
  static const String messages = '/messages';

}

class Routes extends GetxController {
  static List<GetPage> routes = [
    GetPage(name: RouteNames.initial, page: () => const LoadingPage()),
    GetPage(name: RouteNames.login, page: () => const LoginPage()),
    GetPage(name: RouteNames.signup, page: () => const SignUpPage()),
    GetPage(name: RouteNames.home, page: () => const HomePage()),
    GetPage(name: RouteNames.messages, page: () => const MessagesPage()),
  ];
}