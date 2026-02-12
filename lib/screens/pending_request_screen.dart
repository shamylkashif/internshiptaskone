import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/request_controller.dart';
import '../services/request_service.dart';

class PendingRequestScreen extends StatelessWidget {
  PendingRequestScreen({super.key});

  final RequestController controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.pendingRequests.isEmpty) {
        return const Center(
          child: Text("No Pending Requests"),
        );
      }

      return ListView.builder(
        itemCount: controller.pendingRequests.length,
        itemBuilder: (context, index) {
          final request = controller.pendingRequests[index];
          final sender = request.fromUser;

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  sender?.name?.substring(0, 1).toUpperCase() ?? "?",
                ),
              ),

              title: Text(sender?.name ?? "Unknown User"),

              subtitle: const Text("Sent you a request"),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Accept Button
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () async {
                      await RequestService.respondRequest(
                        controller.authController.token.value,
                        request.id!,
                        "accepted",
                      );
                      print("Request Accepted");
                      },
                  ),

                  /// Reject / Block Button
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () async {

                      await RequestService.respondRequest(
                        controller.authController.token.value,
                        request.id!,
                        "blocked",
                      );
                      print("User Blocked");
                      },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
