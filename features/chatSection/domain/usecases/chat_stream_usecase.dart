
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';


abstract class ChatStreamCase{
  Stream trigger(String chatId);
} 

class ChatStreamCaseImp implements ChatStreamCase{
  final FirebaseChatRepository chatRepository;

  ChatStreamCaseImp({required this.chatRepository});

  @override
  Stream trigger(String chatId){
    return chatRepository.checkLastUpdate(chatId);
  }
}