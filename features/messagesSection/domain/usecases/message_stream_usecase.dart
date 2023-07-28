import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class StreamMessageCase{
  Stream trigger(String chatId);
}

class StreamMessageCaseImp implements StreamMessageCase{
  final MessageRepository messageRepository;

  StreamMessageCaseImp({required this.messageRepository});

  @override
  Stream trigger(String chatId){
    return messageRepository.getSentMessage(chatId);
  }

}