
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/data/models/user/gym_user.dart';
import 'package:fitness/core/data/models/user/trainer_user.dart';
import 'package:fitness/core/data/models/user/person_user.dart';

UserModel jsonToUser(Map<String, dynamic> data){
  switch (data["userType"]){
    case 1: 
      GymModel user = GymModel.fromJson(data);
      return user;
    case 2: 
      TrainerModel user = TrainerModel.fromJson(data);
      return user;
    default: 
      PersonModel user = PersonModel.fromJson(data);
      return user;
  }
}