import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/domain/entities/chat.dart';
import 'package:fitness/core/validation/inputValidation.dart';
import 'package:fitness/features/messagesSection/presentation/controllers/messages_controller.dart';
import 'package:fitness/features/messagesSection/presentation/widgets/messsage_container.dart';
import 'package:fitness/widgets/common/buttom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final UserController userController = sl<UserController>();
  final MessagesController messagesController = sl<MessagesController>();
  final Chat chat = Get.arguments as Chat;

  @override
  void initState(){
    super.initState();
    messagesController.setCurrentChat(chat);
    messagesController.loadChatMessages();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: 
              SingleChildScrollView(
                child: Obx(() => Column(
                      children: [
                      messagesController.loading.value ? const CircularProgressIndicator()
                      : 
                      StreamBuilder(
                        stream: messagesController.streamMessages.trigger(chat.id),
                        builder: (context, snapshot){
                          if(snapshot.hasData) messagesController.addMessageFromJson(snapshot.data.snapshot.key as String, snapshot.data.snapshot.value as Map<String, dynamic>);
                          return Column(children : messagesController.chat.value!.messages.map((message) => MessageContainer(message: message)).toList());
                        })
                          
                      ]
                    ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Form(
                key: messagesController.messageBoxFormKey,
                child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: messagesController.messageController,
                            decoration: const InputDecoration(labelText: 'Send Your Message'),
                            validator: (value) {
                                return checkNull(messagesController.messageController);
                            } 
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(onPressed: () => messagesController.sendMessage(), child: Text('submit'))),
                      ],
                    )
              ),
            )
          ]
        ),
      ),
      bottomNavigationBar: Obx(() => customButtomNavigation()),
    );
  }

  @override
  void dispose(){
    messagesController.close();
    super.dispose();
  }
}
