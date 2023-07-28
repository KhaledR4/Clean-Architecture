
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';

class Chat{
  String id;
  List<Message> messages = [];
  List<User> users = [];
  Message lastMessage;
  bool isMessagesLoaded = false;

  Chat({
    required this.id,
    required this.lastMessage,
  });

  void setUsers(List<User> currentUsers){
    users = currentUsers;
  }

  void setLastMessage(Message message){
    lastMessage = message;
  }

  bool isLastMessageRead(User user){
    return lastMessage.isMessageRead(user);
  }

  User getOtherUser(User user){
    if(users[0].getFireUserId() == user.getFireUserId()) return users[1];
    return users[0];
  }
}