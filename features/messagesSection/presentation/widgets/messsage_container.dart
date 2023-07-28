import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/domain/entities/messages.dart';
import 'package:fitness/features/messagesSection/presentation/controllers/messages_controller.dart';
import 'package:fitness/widgets/common/texts/secondary_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class MessageContainer extends StatelessWidget {
  final Message message;
  final UserController userController = sl<UserController>();
  final MessagesController messagesController = sl<MessagesController>();
  MessageContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return 
    Align(
      alignment: message.isMessageFromUser(userController.user.value) ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(message.message),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SecondaryTextInCard(text: message.timeByText()),
                    message.isMessageFromUser(userController.user.value) ? 
                    message.isRead ?
                    const SecondaryTextInCard(text: 'read') :
                    StreamBuilder(
                      stream: messagesController.streamMessageInfo.trigger(messagesController.chat.value!.id, message.id),
                      builder: (context, snapshot){
                        if(snapshot.hasData) messagesController.updateMessageFromJson(message, snapshot.data.snapshot.value as Map<String, dynamic>);
                        return message.isRead ? const SecondaryTextInCard(text: 'read') : const SecondaryTextInCard(text: 'sent');
                      }
                    ) :
                    const SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}