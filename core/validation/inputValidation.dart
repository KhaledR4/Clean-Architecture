import 'package:flutter/material.dart';

String? checkNull(TextEditingController controller){
    if(controller.text.isNotEmpty) return null;
    return 'Please Enter this Field';
  }

  String? checkPassEquality(TextEditingController firstController, TextEditingController secondController){
    if(firstController.text == secondController.text) return null;
    return 'Passwords Should be the same';
  }

  String? checkAllValidators(List<String? Function()> validators){
    for(Function validator in validators){
      String? result = validator();
      if(result != null) return result;
    }
    return null;
  }