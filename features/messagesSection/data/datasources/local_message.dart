import 'dart:convert';
import 'package:fitness/core/data/models/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalMessageSource{
  Future<bool> saveMessagesLocally(String chatId, List<MessageModel> messages);
  Future<List<MessageModel>?> getMessagesLocally(String chatId);
}

class LocalMessageSourceImp implements LocalMessageSource{
  @override
  Future<List<MessageModel>?> getMessagesLocally(String chatId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('messages')) return null; // no messages saved locally
    Map<String, Map<String, dynamic>> data = jsonDecode(prefs.getString('messages')!);
    if(!data.containsKey(chatId)) return null; // no messages of that chat saved locally

    List<MessageModel> messages = [];
    data[chatId]!.forEach((key, value) {
      MessageModel message = MessageModel.fromJson(value);
      message.setId(key);
      messages.add(message);
    });
    return messages;
  }

  @override
  Future<bool> saveMessagesLocally(String chatId, List<MessageModel> messages) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, Map<String, dynamic>> userMessages;
      userMessages = prefs.containsKey('messages') ? Map.from(jsonDecode(prefs.getString('messages')!)) : {};
      Map<String, dynamic> neededChat = userMessages[chatId] ?? {};
      messages.forEach((message) { 
        neededChat[message.id] = message.toJson();
      });
      userMessages[chatId] = neededChat;
      await prefs.setString('messages', jsonEncode(userMessages));
      return true;
    }catch(e){
      return false;
    }
  }
} 