import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class SaveMessageLocallyCase{
  Future<Either<Failure, bool>> trigger(String chatId, List<MessageModel> messages);
}

class SaveMessageLocallyCaseImp implements SaveMessageLocallyCase{
  final MessageRepository messageRepository;

  SaveMessageLocallyCaseImp({required this.messageRepository});

  @override
  Future<Either<Failure, bool>> trigger(String chatId, List<MessageModel> messages) async{
    try{
      await messageRepository.saveMessagesLocally(chatId, messages);
      return const Right(true);
    } on CacheException{
      return Left(CacheFailure());
    }
  }

}