import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';

abstract class SendMessageCase{
  Future<Either<Failure, Message>> sendMessage(String message, String chatId, User user);
}

class SendMessageCaseImp implements SendMessageCase{
  final MessageRepository messageRepository;

  SendMessageCaseImp({required this.messageRepository});

  @override
  Future<Either<Failure, Message>> sendMessage(String message, String chatId, User user) async{
    try{
      MessageModel messageToSent = MessageModel.toSend(message, user);
      await messageRepository.sendMessage(messageToSent, chatId);
      return Right(messageToSent);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}