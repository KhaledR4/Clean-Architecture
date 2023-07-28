import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class ReadMessageCase{
  Future<Either<Failure, List<MessageModel>>> trigger(String chatId);
}

class ReadMessageCaseImp implements ReadMessageCase{
  final MessageRepository messageRepository;

  ReadMessageCaseImp({required this.messageRepository});

  @override
  Future<Either<Failure, List<MessageModel>>> trigger(String chatId) async{
    try{
      final result = await messageRepository.getMessages(chatId);
      return Right(result);
    } on ServerException{
      return Left(ServerFailure());
    } on CacheException{
      return Left(CacheFailure());
    }
  }

}