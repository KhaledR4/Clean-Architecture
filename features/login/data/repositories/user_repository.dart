
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/features/login/data/datasources/login_request.dart';
import 'package:fitness/features/login/domain/repositories/user_repository.dart';

class LoginRepositoryImp implements LoginRepository{
 final LoginRequest loginDataSource;

 LoginRepositoryImp(
  {required this.loginDataSource,}
 );

  @override
  Future<User> signin(String email, String password) async{
    final result = await loginDataSource.signin(email, password);
    if(result == null) throw DataFormException();
    return result;
    
  }


}
