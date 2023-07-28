import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart' as entity;
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';
import 'package:fitness/core/domain/repositories/firebase_user_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/core/network/network_info.dart';
import 'package:fitness/core/usecases/usecase.dart';
import 'package:fitness/features/login/domain/repositories/user_repository.dart';

class LoginCase implements UseCase<entity.User, Map<String, String>>{
  final LoginRepository loginUserRepository;
  final FirebaseAuth firebaseAuthService;
  final FirebaseUserRepository firebaseUserRepositoy;
  final FirebaseChatRepository chatRepository;

  LoginCase({
    required this.loginUserRepository,
    required this.firebaseAuthService, 
    required this.firebaseUserRepositoy,
    required this.chatRepository
  });

  @override
  Future<Either<Failure, entity.User>> trigger(Map<String, String> data) async{
    if(!(await NetworkInfo.isConnected())){
      return Left(NetworkFailure());
    }
    try{
      String email = data["email"]!;
      String password = data["password"]!;
      entity.User user = await loginUserRepository.signin(email, password);
      final firebaseUser = await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
      String firebaseId = firebaseUser.user!.uid;
      user.setFirebaseId(firebaseId);
      return Right(user);
    }on ServerException{
      return Left(ServerFailure());
    }on DataFormException{
      return Left(DataFormFailure(message: 'Incorrect Credentials'));
    }
  }
}
