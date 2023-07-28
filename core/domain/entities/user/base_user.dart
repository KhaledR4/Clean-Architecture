import 'package:equatable/equatable.dart';
import 'package:fitness/core/domain/entities/chat.dart';

class User extends Equatable{
  late String name;
  late String email;
  Map<String, String?> tokens = {
    "Auth": null,
    "fireBaseId": null
  };
  late int userType;
  late String number;
  List<Chat> chats = [];

  User({
    required this.name,
    required this.email,
    required this.userType,
    required this.number,
  });

  User.empty(){
    name = "";
    userType = 3;
    email = "";
    number = "";
  }

  bool isPerson(){
    return userType == 3;
  }

  bool isTrainer(){
    return userType == 2;
  }

  bool isGym(){
    return userType == 1;
  }

  void setAuthToken(String token){
    tokens["Auth"] = token;
  }

  void setFirebaseId(String userId){
    tokens["fireBaseId"] = userId;
  }

  void setChats(List<Chat> currentChats){
    chats = currentChats;
  }

  String getAuthToken(){
    return tokens["Auth"] ?? "";
  }

  String getFireUserId(){
    return tokens["fireBaseId"]!;
  }

  bool canCreateChatWithUser(String userId){
    if(userId == getFireUserId()) return false; // the user can't have chats with himself

    for(int i = 0; i < chats.length; i++){
      for(int j =0; j< chats[i].users.length; j++){
        if(chats[i].users[j].getFireUserId() == userId) return false;
      }
    }
    return true;
  }

  @override
  List<Object> get props => [name, number, userType, email];

}