import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/core/network/network_info.dart';
import 'package:fitness/features/loading/data/datasources/local_data.dart';
import 'package:fitness/features/loading/data/datasources/user_request.dart';
import 'package:fitness/features/loading/domain/repositories/user_repository.dart';

class SigninUserRepositoryImp implements SigninUserRepository{
  final CheckUserToken checkUserToken;
  final UserLocalSource localUser;

  SigninUserRepositoryImp({required this.checkUserToken, required this.localUser});

  @override
  Future<User> signin() async{
    String? token = await localUser.getUserToken();
    if(token == null) throw CacheException();
    if(!(await NetworkInfo.isConnected())) return (await localUser.getUser())!; // there is no connection so return the user saved locally
    final userFromServer = await checkUserToken.getUser(token);
    if(userFromServer == null) throw DataFormException();
    return userFromServer;
  }
}