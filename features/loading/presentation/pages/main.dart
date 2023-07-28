import 'package:fitness/features/loading/presentation/controllers/loading_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final LoadingController loadingController = sl<LoadingController>();

  @override
  void initState(){
    super.initState();
    loadingController.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}