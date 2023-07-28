
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/core/data/models/user/base_user.dart';
import 'package:fitness/core/functionalities/jsonToUser.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart' as entity;

abstract class FirebaseSaveUserRequest{
  Future<bool> saveUser(Map<String, dynamic> data, String userId);
  Future<entity.User> getUserById(String userId);
  Future<List<UserModel>?> searchUsers(String email);
}
class FirebaseSaveUserRequestImp implements FirebaseSaveUserRequest{
  final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');

  @override
  Future<bool> saveUser(Map<String, dynamic> data, String userId) async{
    try{
      DatabaseReference userRef = usersRef.child(userId);
      // Map dataToSet = data.remove('password');
      await userRef.set(
        data
      );
      return true;
    }catch (e){
      return false;
    }
  }

  @override
  Future<entity.User> getUserById(String userId) async {
    DataSnapshot snapshot = await usersRef.child(userId).get();
    Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
    entity.User user = jsonToUser(data);
    user.setFirebaseId(userId);
    return user;
  }

  @override
  Future<List<UserModel>?> searchUsers(String email) async{
   DataSnapshot snapshot = await usersRef.get();
   List<UserModel> searchResult = [];
   Map<String, dynamic> usersMap = snapshot.value! as Map<String, dynamic>;
   usersMap.forEach((key, value) {
    if((value["email"] as String).contains(email)){
      UserModel user = jsonToUser(value);
      user.setFirebaseId(key);
      searchResult.add(user);
    }
   });
   if(searchResult.isEmpty) return null;
   return searchResult;
  }
}