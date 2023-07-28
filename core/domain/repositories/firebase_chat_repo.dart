import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';

abstract class FirebaseChatRepository{
  Future<List<Chat>> getUserChats(String userId);
  Future<ChatModel> getChatById(String chatId);
  Stream checkLastUpdate(String chatId);
  Stream checkNewChat(String chatId);
  Future<ChatModel> createChat(User user, String userReceiveingId);
}