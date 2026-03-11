import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internshiptaskone/screens/chat_screen.dart';
import '../controller/auth_controller.dart';
import '../controller/chat_controller.dart';
import '../controller/request_controller.dart';


class ConnectionsScreen extends StatelessWidget {
  ConnectionsScreen({super.key});

  final RequestController controller = Get.put(RequestController());
  final AuthController authController = Get.find<AuthController>();
  final ChatController chatController = Get.find<ChatController>();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.connections.isEmpty) {
        return const Center(
          child: Text("No Connections Yet"),
        );
      }
      return ListView.builder(
        itemCount: controller.connections.length,
        itemBuilder: (context, index) {
          final request = controller.connections[index];
          /// Decide who is the connection user
          final currentUserId = authController.currentUser.value?.id;
          final connectionUser =
          request.fromUser?.id == currentUserId
              ? request.toUser
              : request.fromUser;

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  connectionUser?.name
                      ?.substring(0, 1).toUpperCase() ?? "NA",
                ),
              ),

              title: Text(connectionUser?.name ?? "Unknown User"),
              subtitle: const Text("Connected"),
                onTap: () async {
                  if (connectionUser == null) return;

                  // 1️⃣ Open or create chat in Firestore
                  await chatController.openChat(
                    otherUserId: connectionUser.id ?? "",
                    otherUserName: connectionUser.name ?? "Unknown",
                    otherUserImage: connectionUser.profileImage ?? "",
                    myName: authController.currentUser.value!.name ?? "Me",
                    myImage: authController.currentUser.value!.profileImage ?? "",
                  );

                  // 2️⃣ Navigate to ChatScreen
                  Get.to(() => ChatScreen(
                    otherUserName: connectionUser.name ?? "Unknown",
                  ));
                },
              ),
          );
        },
      );
    });
  }
}
