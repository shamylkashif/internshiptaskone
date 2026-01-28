import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';

class ChatListScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Obx(
            () => ListView.separated(
          itemCount: controller.chats.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (context, index) {
            final chat = controller.chats[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(chat.name[0]),
              ),
              title: Text(chat.name),
              subtitle: Text(chat.lastMessage),
              trailing: Text(chat.time),
              onTap: () {
                // Navigate to chat detail
                print('Tapped on ${chat.name}');
              },
            );
          },
        ),
      ),
    );
  }
}
