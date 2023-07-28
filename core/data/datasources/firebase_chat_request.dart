import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/core/data/datasources/firebase_user_request.dart';
import 'package:fitness/core/data/models/chat.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/core/domain/entities/user/base_user.dart';

abstract class FirebaseChatRequest{
  Future<List<String>> getUserChatsId(String userId);
  Future<List<String>> getUserOfChat(String chatId);
  Future<ChatModel> getChatById(String chatId);
  Future<ChatModel> createChat(User user, String userReceiveingId);
  Stream checkLastUpdate(String chatId);
  Stream checkNewChat(String userId);
}

class FirebaseChatRequestImp implements FirebaseChatRequest{
  final FirebaseSaveUserRequest userRequest;
  final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
  final DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child('chats');
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('messages');

  FirebaseChatRequestImp({required this.userRequest});

  @override
  Future<List<String>> getUserChatsId(String userId) async{
    try{
      Map<String, dynamic> chatsMap = (await usersRef.child(userId).child('chats').get()).value as Map<String, dynamic>;
      List<String> chats = chatsMap.keys.toList();
      return chats;
    }catch(e){ // user has no chats
      return [];
    }
  }

  @override
  Future<List<String>> getUserOfChat(String chatId) async{
    Map<String, dynamic> usersMap = (await chatsRef.child(chatId).child('users').get()).value as Map<String, dynamic>;
    List<String> users = usersMap.keys.toList();
    return users;
  }

  @override
  Future<ChatModel> getChatById(String chatId) async{
    Map<String, dynamic> lastMessageMap = (await chatsRef.child(chatId).child('last_message').get()).value as Map<String, dynamic>;
    Message lastMessage = MessageModel.fromJson(lastMessageMap);
    ChatModel chat = ChatModel(chatId, lastMessage);

    List<String> chatUserIds = await getUserOfChat(chatId); // list of ids of chats of that user
    List<User> userObjectsOfChat =[];
    for(int j = 0; j < chatUserIds.length; j ++){
      userObjectsOfChat.add(await userRequest.getUserById(chatUserIds[j]));
    }

    chat.setUsers(userObjectsOfChat);
    return chat;
  }

  @override
  Stream checkLastUpdate(String chatId){
    return chatsRef.child(chatId).child('last_message').onValue;
  }

  @override
  Stream checkNewChat(String userId){
    return usersRef.child(userId).child('chats').onChildAdded;
  }

  @override
  Future<ChatModel> createChat(User userSending, String userReceiveingId) async{
    Map<String, dynamic> initialMessage = MessageModel.toSend('Hello!', userSending).toJson();
    DatabaseReference newChatRef = chatsRef.push();
    String newChatId = newChatRef.key!;
    final lastMessageRequest = newChatRef.child('last_message').set(initialMessage); // saving an initial message
    final setUsersRequest = newChatRef.child('users').set({ // adding the users to the created chat
        userReceiveingId: true,
        userSending.getFireUserId(): true
      });
    final addChatToUser = usersRef.child(userReceiveingId).child('chats').update({ // add chatId to user1
      newChatId: true,
    });
    final addChatToSecondUser = usersRef.child(userSending.getFireUserId()).child('chats').update({ // add chatId to user2
      newChatId: true,
    });
    DatabaseReference newMessageRef = messagesRef.child(newChatId).push();
    final saveInitialMessageRequest = newMessageRef.set(initialMessage);
    await lastMessageRequest;
    await setUsersRequest;
    await saveInitialMessageRequest;
    await addChatToSecondUser;
    await addChatToUser;
    return await getChatById(newChatId);
  }
}