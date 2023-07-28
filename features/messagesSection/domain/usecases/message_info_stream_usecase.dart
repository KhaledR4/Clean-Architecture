import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class StreamMessageInfoCase{
  Stream trigger(String chatId, String messageId);
}

class StreamMessageInfoCaseImp implements StreamMessageInfoCase{
  final MessageRepository messageRepository;

  StreamMessageInfoCaseImp({required this.messageRepository});

  @override
  Stream trigger(String chatId, String messageId){
    return messageRepository.getMessageUpdatedInfo(chatId, messageId);
  }

}