import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String chatId;
  String lastMessage;
  Timestamp lastMessageTime;
  List participants;
  Map<String, dynamic> userNames;
  Map<String, dynamic> userImages;

  ChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participants,
    required this.userNames,
    required this.userImages,
  });

  factory ChatModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      chatId: doc.id,
      lastMessage: data["lastMessage"] ?? "",
      lastMessageTime: data["lastMessageTime"] ?? Timestamp.now(),
      participants: data["participants"],
      userNames: data["userNames"],
      userImages: data["userImages"],
    );
  }
}