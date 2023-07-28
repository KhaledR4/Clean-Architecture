import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/chatSection/domain/usecases/chat_stream_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/create_chat_usercase.dart';
import 'package:fitness/features/chatSection/domain/usecases/get_chat_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/new_chat_stream_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/search_users_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ChatPageController extends GetxController{
  final ChatStreamCase chatUseCase;
  final StreamNewChatCase newChatStream;
  final GetNewChatCase getNewChatCase;
  final SearchUserCase searchUserCase;
  final CreateNewChatCase createNewChatCase;

  final UserController userController = sl<UserController>();

  final TextEditingController searchController = TextEditingController();
  
  RxList<UserModel> searchedUsers = RxList([]);
  RxList<ChatModel> chats = RxList([]);

  listenToChats(){
    chats.value = List.from(userController.user.value.chats);

    newChatStream.trigger(userController.user.value.getFireUserId()).listen((event) {
      String? data = event.snapshot.key;
      if(data == null) return;
      print(data);
      
      addNewChat(data);
      
    });
  }
  

  ChatPageController({
    required this.chatUseCase, 
    required this.searchUserCase, 
    required this.newChatStream, 
    required this.getNewChatCase,
    required this.createNewChatCase
  });



  Message updateLatestMessageFromJson(Chat chat, Map<String, dynamic> data){
    Message lastMessage = MessageModel.fromJson(data);
    chat.setLastMessage(lastMessage);
    return lastMessage;
  }

  addNewChat(String chatId) async{
    final result = await getNewChatCase.trigger(chatId);
    result.fold(
      (failure)  {print(failure.runtimeType);},
      (chat) {
        chats.add(chat); 
        userController.user.value.chats = List.from(chats);
      }
    );
  }

  createChat(String userId) async{
    final result = await createNewChatCase.trigger(userController.user.value, userId);
    result.fold((failure) {
        if(failure is DataFormFailure) print("already exists");
      }, (r) {
        null;
      }
    );
    searchController.text = "";
    searchedUsers.value = [];
  }

  searchUsers(String value) async{
    if(value.isEmpty){
      searchedUsers.value = [];
      return;
    }

    final result = await searchUserCase.trigger(value);
    result.fold(
      (failure) {
        searchedUsers.value = [];
      },
      (users) { 
        searchedUsers.value = users;
      }
    );
  }
}