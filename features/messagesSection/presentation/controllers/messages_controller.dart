import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/data/models/messages.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/features/messagesSection/domain/usecases/make_messages_read_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/message_info_stream_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/message_stream_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/read_messages_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/read_unread_messages_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/save_messages_locally_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/send_message_usecase.dart';
import 'package:fitness/widgets/notifiers/toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class MessagesController extends GetxController{
  final messageBoxFormKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  RxBool loading = RxBool(true);
  Rxn<Chat> chat = Rxn();
  List<MessageModel> messagesToSaveLocally = [];

  final UserController userController = sl<UserController>();

  final SendMessageCase sendMessageCase;
  final ReadMessageCase readMessageCase;
  final MakeReadMessageCase makeReadMessageCase;
  final StreamMessageCase streamMessages;
  final StreamMessageInfoCase streamMessageInfo;
  final UnReadMessageCase unReadMessageCase;
  final SaveMessageLocallyCase saveMessageLocallyCase;

  MessagesController({
    required this.sendMessageCase, 
    required this.readMessageCase, 
    required this.streamMessages, 
    required this.streamMessageInfo,
    required this.makeReadMessageCase,
    required this.unReadMessageCase,
    required this.saveMessageLocallyCase
  });

  setCurrentChat(Chat currentChat){
    chat.value = currentChat;
    loading.value = true;
  }

  addMessageFromJson(String messageId, Map<String, dynamic> newMessage){
    MessageModel message = MessageModel.fromJson(newMessage);
    message.setId(messageId);
    // the following if statement is checking if the new message has the same id
    // as the last one, we do this because when we enter the messages page the stream
    // is getting the last message as a new created message.
    // so without this the last message will be displayed twice
    if(chat.value!.messages[chat.value!.messages.length - 1].id != message.id){
      if(!message.isMessageFromUser(userController.user.value)){
        chat.value!.lastMessage = message;
        makeReadMessageCase.trigger(chat.value!.id, [message]);
      }
      messagesToSaveLocally.add(message);
      chat.value!.messages.add(message);
    }
  }

  updateMessageFromJson(Message message, Map<String, dynamic> data){
    Message updatedMessage = MessageModel.fromJson(data);
    message.isRead = updatedMessage.isRead;
  }

  sendMessage() async{
    if(messageController.text.isEmpty) return null;
    final result = await sendMessageCase.sendMessage(messageController.text, chat.value!.id, userController.user.value);

    result.fold(
      (failure) => Toast.neutralToast("Message couldn't be sent"),
      (message) {
        chat.value!.lastMessage = message;
      });
  }

  loadChatMessages() async{
    if(chat.value!.isMessagesLoaded){ // messages were already loaded before so now only get unread new ones
      final result = await unReadMessageCase.trigger(chat.value!.id, userController.user.value.getFireUserId());
      loading.value = false;
      result.fold(
        (failure)  {},
        (gottenMessages) {
          chat.value!.messages.addAll(gottenMessages);
          messagesToSaveLocally.addAll(gottenMessages);
          makeReadMessageCase.trigger(chat.value!.id, gottenMessages);
        });
      return;
    }

    // first time reading messages of this chat
    chat.value!.isMessagesLoaded = true;
    final result = await readMessageCase.trigger(chat.value!.id);
    result.fold(
      (failure)  {},
      (gottenMessages) {
        chat.value!.messages = gottenMessages;
        messagesToSaveLocally.addAll(gottenMessages);
        List<MessageModel> unreadMessages = gottenMessages.where((message) => !message.isMessageFromUser(userController.user.value) && !message.isRead).toList();
        if(unreadMessages.isNotEmpty) makeReadMessageCase.trigger(chat.value!.id, unreadMessages);
      });
    
    loading.value = false;
  }

  close(){
    saveMessageLocallyCase.trigger(chat.value!.id, messagesToSaveLocally);
  }
}