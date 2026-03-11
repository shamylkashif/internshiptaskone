import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/chat_controller.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final ChatController controller = Get.find();
  final AuthController authController = Get.find();

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.chatList.isEmpty) {
          return const Center(child: Text("No Chats Available"));
        }

        return ListView.builder(
          itemCount: controller.chatList.length,
          itemBuilder: (context, index) {
            final chat = controller.chatList[index];
            String otherUserId = chat.participants
                .firstWhere((id) => id != authController.currentUser.value!.id);

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chat.userImages[otherUserId]),
              ),
              title: Text(chat.userNames[otherUserId]),
              subtitle: Text(chat.lastMessage),
              onTap: () async {
                await controller.openChat(
                  otherUserId: otherUserId,
                  otherUserName: chat.userNames[otherUserId],
                  otherUserImage: chat.userImages[otherUserId],
                  myName: chat.userNames[authController.currentUser.value!.id],
                  myImage: chat.userImages[authController.currentUser.value!.id],
                );

                Get.to(() => ChatScreen(
                  otherUserName: chat.userNames[otherUserId],
                ));
              },
            );
          },
        );
      }),
    );
  }
}