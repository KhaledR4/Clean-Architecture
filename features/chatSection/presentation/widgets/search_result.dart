import 'package:fitness/core/domain/entities/user/base_user.dart';
import 'package:fitness/features/chatSection/presentation/controllers/chat_page_controller.dart';
import 'package:fitness/widgets/common/texts/secondary_text.dart';
import 'package:flutter/material.dart';

class SearchBoxResult extends StatelessWidget {
  final User user;
  final ChatPageController chatPageController = sl<ChatPageController>();
  SearchBoxResult({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => chatPageController.createChat(user.getFireUserId()),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name,
              style: const TextStyle(
              color:  Colors.black
            )),

            const SizedBox(height: 5),

            SecondaryTextInCard(text: user.email)
          ],
        ),
      ),
    );
  }
}