import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart' as entity;
import 'package:fitness/core/domain/repositories/firebase_user_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/network/network_info.dart';
import 'package:fitness/features/signup/domain/repositories/singup.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SignupCase implements UseCase<entity.User, Map<String, dynamic>> {
  final SignUpRepository repository;
  final FirebaseUserRepository firebaseRepository;
  final FirebaseAuth firebaseAuthService;
  final LocalSaveUserRepository localSaveUserRepository;

  SignupCase({required this.repository, required this.firebaseAuthService, required this.firebaseRepository, required this.localSaveUserRepository});

  @override
  Future<Either<Failure, entity.User>> trigger(Map<String, dynamic> data) async {
    if(!(await NetworkInfo.isConnected())){
      return Left(NetworkFailure());
    }
    
    try{
      final entity.User result = await repository.signup(data);

      final firebaseUser = await firebaseAuthService.createUserWithEmailAndPassword(email: data["email"], password: data["password"]);
      result.setFirebaseId(firebaseUser.user!.uid);
      if(firebaseUser.user == null) return Left(ServerFailure());

      bool firebaseSaveResult = await firebaseRepository.saveUser(data, firebaseUser.user!.uid);
      if(!firebaseSaveResult) return Left(ServerFailure());

      bool localSaveResult = await localSaveUserRepository.saveUser((result as UserModel).toJson());
      if(!localSaveResult) return Left(CacheFailure());

      return Right(result);
    } on DataFormException{
      return Left(DataFormFailure(message: 'Email Already registered'));
    } 
    catch (e){
      return Left(ServerFailure());
    }
  }
}