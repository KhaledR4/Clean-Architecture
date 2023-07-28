
import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/core/error/exceptions.dart';
import 'package:fitness/features/signup/data/datasources/signup_request.dart';
import 'package:fitness/features/signup/domain/repositories/singup.dart';

class SignUpRepositoryImp implements SignUpRepository{
 final SignUpRequestImp signupDataSource;

 SignUpRepositoryImp(
  {required this.signupDataSource,}
 );

  @override
  Future<User> signup(Map<String, dynamic> data) async{
    final result = await signupDataSource.signup(data);
    if(result == null) throw DataFormException();
    return result;
  }


}