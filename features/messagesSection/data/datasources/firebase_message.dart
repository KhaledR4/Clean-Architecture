import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/messages.dart';

abstract class FirebaseMessagesRequest{
  Future<Message?> sendMessage(MessageModel message, String chatId);
  Future<List<MessageModel>?> getMessages(String chatId);
  Stream getSentMessage(String chatId);
  Stream getMessageUpdatedInfo(String chatId, String messageId);
  Future<bool> makeMessageRead(String chatId, String messageId);
  Future<List<MessageModel>?> getUnreadMessages(String chatId, String userId);
}

class FirebaseMessagesRequestImp implements FirebaseMessagesRequest{
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('messages');
  final DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child('chats');

  @override
  Future<Message?> sendMessage(MessageModel message, String chatId) async{
    try{
      Map<String, dynamic> messageMap = message.toJson();
      DatabaseReference lastMessageRef = chatsRef.child(chatId).child('last_message');
      DatabaseReference newMessageRef = messagesRef.child(chatId).push();
      final updateLastMessage = lastMessageRef.update(messageMap);
      final addNewMessage = newMessageRef.set(messageMap);
      message.id = newMessageRef.key!;
      await updateLastMessage;
      await addNewMessage;
      return message;
    } catch(e){
      return null;
    }
  }

  @override
  Future<List<MessageModel>?> getMessages(String chatId) async{
    try{
      List<MessageModel> messages = [];
      Map<String, dynamic> chats = (await messagesRef.child(chatId).get()).value as Map<String, dynamic>;
      chats.forEach((key, value) {
        MessageModel message = MessageModel.fromJson(value);
        message.setId(key);
        messages.add(message);
      });
      return messages;
    }catch(e){
      return null;
    }
  }

  @override
  Future<List<MessageModel>?> getUnreadMessages(String chatId, String userId) async{
    try{
      List<MessageModel> messages = [];
      Map<String, dynamic> chats = (await messagesRef.child(chatId).get()).value as Map<String, dynamic>;
      chats.forEach((key, value) {
        if(value["sender"] != userId && !value["isRead"]){ // meaning the message is not from the current user, and he hasn't read it yet
          MessageModel message = MessageModel.fromJson(value);
          message.setId(key);
          messages.add(message);
        }
      });
      return messages;
    }catch(e){
      return null;
    }
  }

  @override
  Stream getSentMessage(String chatId){
    return messagesRef.child(chatId).onChildAdded;
  }

  @override
  Stream getMessageUpdatedInfo(String chatId, String messageId){
    return messagesRef.child(chatId).child(messageId).onValue;
  }

  @override
  Future<bool> makeMessageRead(String chatId, String messageId) async{
    try{
      await messagesRef.child(chatId).child(messageId).update({
        "isRead": true
      });
      await chatsRef.child(chatId).child('last_message').update({
        "isRead": true
      });
      return true;
    }catch(e){
      return false;
    }
  }

}