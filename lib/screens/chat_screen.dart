import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final String otherUserId;
  final String otherUserName;
  final String otherUserImage;

  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  ChatScreen({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserImage,
  });

  @override
  Widget build(BuildContext context) {
    chatController.listenMessages(otherUserId);

    return Scaffold(
      appBar: AppBar(title: Text(otherUserName)),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatController.messages[index].data();
                  final isMe = msg['senderId'] == chatController.currentUserId;

                  return Align(
                    alignment:
                    isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration:
                    const InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = messageController.text.trim();
                    if (text.isNotEmpty) {
                      chatController.sendMessage(
                        text: text,
                        receiverId: otherUserId,
                        receiverName: otherUserName,
                        receiverImage: otherUserImage,
                      );
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
