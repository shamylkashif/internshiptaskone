import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    chatController.listenChatList();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Chats"),
          automaticallyImplyLeading: false,
          centerTitle: true,
      ),
      body: Obx(() {
        final chats = chatController.chatList;

        if (chats.isEmpty) {
          return const Center(child: Text("No chats yet"));
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index].data();
            final participants = chat['participants'] as List<dynamic>;
            final otherUserId = participants.firstWhere(
                  (id) => id != chatController.currentUserId,
              orElse: () => null,
            );

            if (otherUserId == null) return const SizedBox();

            final userNames = chat['userNames'] as Map<String, dynamic>;
            final userImages = chat['userImages'] as Map<String, dynamic>;
            final lastMessage = chat['lastMessage'] ?? "";

            final otherUserName = userNames[otherUserId] ?? "Unknown";
            final otherUserImage = userImages[otherUserId] ?? "";

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: otherUserImage.isNotEmpty
                    ? NetworkImage(otherUserImage)
                    : null,
                child: otherUserImage.isEmpty ? const Icon(Icons.person) : null,
              ),
              title: Text(otherUserName),
              subtitle: Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Get.to(() => ChatScreen(
                  otherUserId: otherUserId,
                  otherUserName: otherUserName,
                  otherUserImage: otherUserImage,
                ));
              },
            );
          },
        );
      }),
    );
  }
}
