import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/chat_service.dart';
import 'auth_controller.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final AuthController authController = Get.find<AuthController>();

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> messages =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> chatList =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  String get currentUserId => authController.currentUser.value?.id ?? "";
  String get currentUserName => authController.currentUser.value?.name ?? "Unknown";
  String get currentUserImage => authController.currentUser.value?.profileImage ?? "";

  /// Listen to messages in a chat with another user
  void listenMessages(String otherUserId) {
    if (currentUserId.isEmpty) return;
    _chatService.getMessages(currentUserId, otherUserId).listen((snapshot) {
      messages.value = snapshot.docs;
    });
  }

  /// Listen to the chat list for current user
  void listenChatList() {
    if (currentUserId.isEmpty) return;
    _chatService.getChatList(currentUserId).listen((snapshot) {
      chatList.value = snapshot.docs;
    });
  }

  /// Send a message
  Future<void> sendMessage({
    required String text,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
  }) async {
    if (currentUserId.isEmpty) return;

    await _chatService.sendMessage(
      senderId: currentUserId,
      senderName: currentUserName,
      senderImage: currentUserImage,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverImage: receiverImage,
      text: text,
    );
  }

  /// Mark message as read
  Future<void> markRead(String chatId, String messageId) async {
    if (currentUserId.isEmpty) return;
    await _chatService.markMessageRead(chatId, messageId, currentUserId);
  }
}
