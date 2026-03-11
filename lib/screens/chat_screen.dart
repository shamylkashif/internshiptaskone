import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/chat_controller.dart';


class ChatScreen extends StatelessWidget {
  final String otherUserName;
  final ChatController controller = Get.find();
  final AuthController authController = Get.find();
  final TextEditingController messageController = TextEditingController();

  ChatScreen({super.key, required this.otherUserName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(otherUserName)),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  bool isMe = msg.senderId == authController.currentUser.value!.id;

                  return Align(
                    alignment:
                    isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.green : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(msg.text),
                    ),
                  );
                },
              );
            }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: "Type message"),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  controller.sendMessage(messageController.text);
                  messageController.clear();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}