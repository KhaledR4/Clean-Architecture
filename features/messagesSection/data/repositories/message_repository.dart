import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/network/network_info.dart';
import 'package:fitness/features/messagesSection/data/datasources/firebase_message.dart';
import 'package:fitness/features/messagesSection/data/datasources/local_message.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

class MessageRepositoryImp implements MessageRepository{
  final FirebaseMessagesRequest messagesRequest;
  final LocalMessageSource localMessageSource;

  MessageRepositoryImp({required this.messagesRequest, required this.localMessageSource});

  @override
  Future<Message> sendMessage(MessageModel message, String chatId) async{
    final result = await messagesRequest.sendMessage(message, chatId);
    if(result == null) throw ServerException();
    return result;
  }

  @override 
  Future<List<MessageModel>> getMessages(String chatId) async{
    if(await NetworkInfo.isConnected()) {
      final result = await messagesRequest.getMessages(chatId);
      if(result == null) throw ServerException();
      return result;
    }else{
      final result = await localMessageSource.getMessagesLocally(chatId);
      if(result == null) throw CacheException();
      return result;
    }
    
  }

  @override
  Future<List<MessageModel>> getUnreadMessages(String chatId, String userId) async{
    final result = await messagesRequest.getUnreadMessages(chatId, userId);
    if(result == null) throw ServerException();
    return result;
  }

  @override
  Future<bool> makeMessageRead(String chatId, String messageId) async{
    final result = await messagesRequest.makeMessageRead(chatId, messageId);
    if(!result) throw ServerException();
    return result;
  }

  @override
  Stream getSentMessage(String chatId){
    return messagesRequest.getSentMessage(chatId);
  }

  @override
  Stream getMessageUpdatedInfo(String chatId, String messageId){
    return messagesRequest.getMessageUpdatedInfo(chatId, messageId);
  }

  @override
  Future<bool> saveMessagesLocally(String chatId, List<MessageModel> messages) async{
    final result = await localMessageSource.saveMessagesLocally(chatId, messages);
    if(!result) throw CacheException();
    return result;
  }
}