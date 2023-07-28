import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/domain/entities/messages.dart';

class ChatModel extends Chat{
  ChatModel(String chatId, Message lastMessage): super(id: chatId, lastMessage: lastMessage);
}