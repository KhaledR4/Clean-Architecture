import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';


abstract class StreamNewChatCase{
  Stream trigger(String userId);
}

class StreamNewChatCaseImp implements StreamNewChatCase{
  final FirebaseChatRepository chatRepository;

  StreamNewChatCaseImp({required this.chatRepository});

  @override
  Stream trigger(String userId){
    return chatRepository.checkNewChat(userId);
  }
}