import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/messages.dart';

abstract class MessageRepository{
  Future<Message> sendMessage(MessageModel message, String chatId);
  Future<List<MessageModel>> getMessages(String chatId);
  Future<List<MessageModel>> getUnreadMessages(String chatId, String userId);
  Stream getSentMessage(String chatId);
  Stream getMessageUpdatedInfo(String chatId, String messageId);
  Future<bool> makeMessageRead(String chatId, String messageId);
  Future<bool> saveMessagesLocally(String chatId, List<MessageModel> messages);
}