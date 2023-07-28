import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/features/chatSection/presentation/controllers/chat_page_controller.dart';
import 'package:fitness/features/chatSection/presentation/widgets/chat_container.dart';
import 'package:fitness/features/chatSection/presentation/widgets/search_result.dart';
import 'package:fitness/widgets/common/buttom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatPageController chatPageController = sl<ChatPageController>();
  final UserController userController = sl<UserController>();

  @override
  void initState(){
    super.initState();
    chatPageController.listenToChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: 
        Column(
            children: [
              TextField(
                onChanged: chatPageController.searchUsers,
              ),
              Stack(
                children: [
                  Obx(() => 
                    Column(children: [...chatPageController.chats.map((chat) => 
                      StreamBuilder(
                        stream: chatPageController.chatUseCase.trigger(chat.id),
                        builder: (context, snapshot){
                          if(snapshot.hasData) chatPageController.updateLatestMessageFromJson(chat, snapshot.data.snapshot.value as Map<String, dynamic>);
                          return ChatBoxContainer(chat: chat);
                        })
                      ).toList(),
                    ]),
                  ),
                  Obx(() => Column(children: [
                    ...chatPageController.searchedUsers.map((user) => 
                    SearchBoxResult(user: user)
                  ).toList(),
                  ],
                  )),
                ],
              ),
            ]     
        )
      ),
      bottomNavigationBar: customButtomNavigation()
    );
  }
}