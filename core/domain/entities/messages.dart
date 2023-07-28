import 'package:fitness/core/domain/entities/user/base_user.dart';

class Message{
  late String id;
  String message;
  DateTime time;
  String senderId;
  bool isSent;
  bool isRead;
  String userName;

  Message({required this.message, required this.time, required this.senderId, required this.isRead, required this.isSent, required this.userName});

  setId(String sentId){
    id = sentId;
  }

  bool isMessageRead(User user){
    if(isMessageFromUser(user)) return true;
    return isRead;
  }

  bool isMessageFromUser(User user){
    return senderId == user.getFireUserId();
  }

  String timeByText(){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (time.isAfter(today)) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (time.isAfter(yesterday)) {
      return 'Yesterday';
    } else {
      return '${time.day.toString().padLeft(2, '0')}-${time.month.toString().padLeft(2, '0')}-${time.year}';
    }
  }
}