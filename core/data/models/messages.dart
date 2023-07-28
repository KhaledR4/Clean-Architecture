import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';

class MessageModel extends Message{
  MessageModel({
    required String message,
    required DateTime time,
    required String senderId,
    required bool isRead,
    required bool isSent,
    required String userName
  }) : super(
  message: message,
  time: time,
  isRead: isRead,
  isSent: isSent,
  senderId: senderId,
  userName: userName
  );

  factory MessageModel.fromJson(Map<String, dynamic> data){
    return MessageModel(
      message: data["message"],
      time: DateTime.parse(data["time"]),
      senderId: data["sender"], 
      isRead: data["isRead"], 
      isSent: data["isSent"],
      userName: data["user_name"],
      );
  }

  factory MessageModel.toSend(String message, User user){
    return MessageModel(
      message: message, 
      time: DateTime.now(), 
      senderId: user.getFireUserId(), 
      isRead: false, 
      isSent: true, 
      userName: user.name);
  }

  Map<String, dynamic> toJson(){
    return {
      "message": message,
      "time": time.toString(),
      "isSent": isSent,
      "isRead": isRead,
      "sender": senderId,
      "user_name": userName
    };
  }
}