import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class UnReadMessageCase{
  Future<Either<Failure, List<MessageModel>>> trigger(String chatId, String userId);
}

class UnReadMessageCaseImp implements UnReadMessageCase{
  final MessageRepository messageRepository;

  UnReadMessageCaseImp({required this.messageRepository});

  @override
  Future<Either<Failure, List<MessageModel>>> trigger(String chatId, String userId) async{
    try{
      final result = await messageRepository.getUnreadMessages(chatId, userId);
      return Right(result);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}