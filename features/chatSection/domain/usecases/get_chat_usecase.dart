import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';

abstract class GetNewChatCase{
  Future<Either<Failure, ChatModel>> trigger(String chatId);
}

class GetNewChatCaseImp implements GetNewChatCase{
  final FirebaseChatRepository chatRepository;

  GetNewChatCaseImp({required this.chatRepository});

  @override
  Future<Either<Failure, ChatModel>> trigger(String chatId) async{
    try{
      final result = await chatRepository.getChatById(chatId);
      return Right(result);
    } on NetworkException{
      return Left(NetworkFailure());
    }
  }

}