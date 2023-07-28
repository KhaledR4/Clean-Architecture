import 'package:dartz/dartz.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class MakeReadMessageCase{
  Future<Either<Failure, List<Message>>> trigger(String chatId, List<Message> messages);
}

class MakeReadMessageCaseImp implements MakeReadMessageCase{
  final MessageRepository messageRepository;

  MakeReadMessageCaseImp({required this.messageRepository});

  @override
  Future<Either<Failure, List<Message>>> trigger(String chatId, List<Message> messages) async{
    for(int i= 0; i< messages.length; i++){
      try{
        await messageRepository.makeMessageRead(chatId, messages[i].id);
        messages[i].isRead = true;
      }on ServerException{
        return Left(ServerFailure());
      }
    }
    return Right(messages);
  }

}