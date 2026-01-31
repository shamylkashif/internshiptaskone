import 'package:internshiptaskone/screens/chat_screen.dart';
import 'package:internshiptaskone/utils/app_imports.dart';
import '../controller/chat_controller.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: const Text('Chats'),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.chats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 15),
                Text(
                  "No chat found",
                  style: AppConstants.heading2.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  "Connect with other users",
                  style: AppConstants.smallText,
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.chats.length,
          separatorBuilder: (_, __) => Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey[300],
          ),
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
                Get.to(() => ChatScreen());
              },
            );
          },
        );
      }),

    );
  }

}
