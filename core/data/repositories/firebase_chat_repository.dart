
import 'package:fitness/core/data/datasources/firebase_chat_request.dart';
import 'package:fitness/core/data/datasources/firebase_user_request.dart';
import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart' as entity;
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/network/network_info.dart';

class FirebaseChatRepositoryImp implements FirebaseChatRepository{
  final FirebaseChatRequest chatRequest;
  final FirebaseSaveUserRequest userRequest;

  FirebaseChatRepositoryImp({required this.chatRequest, required this.userRequest});

  @override
  Stream checkLastUpdate(String chatId){
    return chatRequest.checkLastUpdate(chatId);
  }

  @override
  Stream checkNewChat(String userId){
    return chatRequest.checkNewChat(userId);
  }

  
  @override
  Future<List<Chat>> getUserChats(String userId) async{
    List<Chat> userChats = []; // list of chats to return 
    List<String> userChatIds = await chatRequest.getUserChatsId(userId); // list of the id of chats the user has

    for(int i = 0; i < userChatIds.length; i++){
      Chat chat = await chatRequest.getChatById(userChatIds[i]);  // chat object which has no users yet
      userChats.add(chat);
    }
    return userChats;
  }

  @override
  Future<ChatModel> createChat(entity.User user, String userReceiveingId) async{
    if(!(await NetworkInfo.isConnected())) throw NetworkException();
    if(!user.canCreateChatWithUser(userReceiveingId)) throw DataFormException();
    return await chatRequest.createChat(user, userReceiveingId);
  }

  @override
  Future<ChatModel> getChatById(String chatId) async{
    return await chatRequest.getChatById(chatId);
  }
}