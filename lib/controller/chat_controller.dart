import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../utils/chat_utils.dart';
import 'auth_controller.dart';

class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get your Node.js AuthController
  final AuthController authController = Get.find();

  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  RxString currentChatId = "".obs;

  String? get currentUserId => authController.currentUser.value?.id;

  @override
  void onInit() {
    super.onInit();
    authController.currentUser.listen((user) {
      if (user != null) listenChats();
    });
  }

  /// Listen to chat list for current user
  void listenChats() {
    final uid = currentUserId;
    if (uid == null) return;
    firestore
        .collection("chats")
        .where("participants", arrayContains: currentUserId)
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .listen((snapshot) {
      chatList.value =
          snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();
    });
  }

  /// Open chat (create if not exists)
  Future<void> openChat({
    required String otherUserId,
    required String otherUserName,
    required String otherUserImage,
    required String myName,
    required String myImage,
  }) async {
    String chatId = generateChatId(currentUserId!, otherUserId);

    final ref = firestore.collection("chats").doc(chatId);
    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set({
        "participants": [currentUserId, otherUserId],
        "lastMessage": "",
        "lastMessageTime": FieldValue.serverTimestamp(),
        "userNames": {
          currentUserId: myName,
          otherUserId: otherUserName,
        },
        "userImages": {
          currentUserId: myImage,
          otherUserId: otherUserImage,
        }
      });
    }

    currentChatId.value = chatId;
    listenMessages(chatId);
  }

  /// Listen messages in a chat
  void listenMessages(String chatId) {
    firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .listen((snapshot) {
      messages.value =
          snapshot.docs.map((doc) => MessageModel.fromDoc(doc)).toList();
    });
  }

  /// Send message in current chat
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final chatId = currentChatId.value;

    final message = {
      "senderId": currentUserId,
      "text": text,
      "type": "text",
      "timestamp": FieldValue.serverTimestamp(),
      "readBy": [currentUserId]
    };

    final messageRef =
    firestore.collection("chats").doc(chatId).collection("messages");

    final chatRef = firestore.collection("chats").doc(chatId);

    await messageRef.add(message);

    await chatRef.update({
      "lastMessage": text,
      "lastMessageTime": FieldValue.serverTimestamp(),
    });
  }
}
