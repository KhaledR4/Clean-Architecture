import 'package:dartz/dartz.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';
import 'package:fitness/core/usecases/usecase.dart';
import 'package:fitness/features/loading/domain/repositories/user_repository.dart';

class SigninCase implements UseCase<User, NoParams>{
  final SigninUserRepository signinUserRepository;

  SigninCase({required this.signinUserRepository});

  @override
  Future<Either<Failure, User>> trigger(NoParams params) async{
    try{
      User user = await signinUserRepository.signin();
      return Right(user);
    } on CacheException{
      return Left(CacheFailure());
    } on DataFormException{
      return Left(DataFormFailure(message: 'Token not valid'));
    }
  }
}