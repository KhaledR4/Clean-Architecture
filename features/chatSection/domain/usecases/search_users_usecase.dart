import 'package:dartz/dartz.dart';
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/domain/repositories/firebase_user_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/error/failures.dart';

abstract class SearchUserCase{
  Future<Either<Failure, List<UserModel>>> trigger(String email);
}

class SearchUserCaseImp implements SearchUserCase{
  final FirebaseUserRepository userRepository;

  SearchUserCaseImp({required this.userRepository});

  @override
  Future<Either<Failure, List<UserModel>>> trigger(String email) async{
    try{
      final result = await userRepository.searchUsers(email);
      return Right(result);
    } on NetworkException{
      return Left(NetworkFailure());
    } on DataFormException{
      return Left(DataFormFailure(message: "Can't find users with given input"));
    }
  }

}