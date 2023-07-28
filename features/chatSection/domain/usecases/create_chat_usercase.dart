import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';

abstract class CreateNewChatCase{
  Future<Either<Failure, ChatModel>> trigger(User user, String userReceiveingId);
}

class CreateNewChatCaseImp implements CreateNewChatCase{
  final FirebaseChatRepository chatRepository;

  CreateNewChatCaseImp({required this.chatRepository});

  @override
  Future<Either<Failure, ChatModel>> trigger(User user, String userReceiveingId) async{
    try{
      final result = await chatRepository.createChat(user, userReceiveingId);
      return Right(result);
    } on NetworkException{
      return Left(NetworkFailure());
    } on DataFormException{
      return Left(DataFormFailure(message: "Already have a chat with this user"));
    }
  }

}