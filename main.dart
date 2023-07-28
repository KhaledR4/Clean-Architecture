import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/constants/app_constants.dart';
import 'package:fitness/constants/routes.dart';
import 'package:fitness/constants/theme.dart';
import 'package:fitness/constants/translations/translation.dart';
import 'package:fitness/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'injection.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      theme: darkTheme,
      getPages: Routes.routes,
      initialRoute: RouteNames.initial,
      translations: Messages(),
    );
  }
}

