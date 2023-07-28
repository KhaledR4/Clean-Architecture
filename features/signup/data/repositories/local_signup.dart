import 'package:fitness/features/signup/data/datasources/local_save_user.dart';
import 'package:fitness/features/signup/domain/repositories/singup.dart';

class LocalSaveUserRepositoryImp implements LocalSaveUserRepository{
  final LocalUser signupDataSource;

  LocalSaveUserRepositoryImp(
    {required this.signupDataSource,}
  );

  @override
  Future<bool> saveUser(Map<String, dynamic> data) async{
    return await signupDataSource.saveUser(data);
  }
}