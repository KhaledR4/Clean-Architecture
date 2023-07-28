import 'package:fitness/constants/routes.dart';
import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ChatBoxContainer extends StatelessWidget {
  final Chat chat;
  final UserController userController = sl<UserController>();
  ChatBoxContainer({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return 
    GestureDetector(
      onTap: () => Get.toNamed(RouteNames.messages, arguments: chat),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(chat.getOtherUser(userController.user.value).name,
                    style: textTheme.headlineSmall,
                    ),
                    Text(chat.lastMessage.timeByText()),
                  ],
                ),
    
                const SizedBox(height: 8),
    
                Text(chat.lastMessage.message,
                style: TextStyle(
                  color:  chat.isLastMessageRead(userController.user.value) ? Colors.grey : Colors.white,
                  fontWeight: chat.isLastMessageRead(userController.user.value) ? FontWeight.normal : FontWeight.bold
                ),
                )
              ],
            ),
          )
        ),
    );
  }
}