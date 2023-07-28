
import 'package:fitness/core/data/datasources/firebase_user_request.dart';
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/domain/repositories/firebase_user_repo.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/network/network_info.dart';



class FirebaseUserRepositoryImp implements FirebaseUserRepository{
  final FirebaseSaveUserRequest firebaseDataSource;

  FirebaseUserRepositoryImp(
    {required this.firebaseDataSource,}
  );

  @override
  Future<bool> saveUser(Map<String, dynamic> data, String userId) async{
    return await firebaseDataSource.saveUser(data, userId);
  }

  @override
  Future<List<UserModel>> searchUsers(String email) async{
    if(!(await NetworkInfo.isConnected())) throw NetworkException();
    final result = await firebaseDataSource.searchUsers(email);
    if(result == null) throw DataFormException();
    return result;
  }

  
}