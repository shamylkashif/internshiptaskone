import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId;
  String text;
  String type;
  Timestamp timestamp;
  List readBy;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.type,
    required this.timestamp,
    required this.readBy,
  });

  factory MessageModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MessageModel(
      senderId: data["senderId"],
      text: data["text"],
      type: data["type"],
      timestamp: data["timestamp"] ?? Timestamp.now(),
      readBy: data["readBy"],
    );
  }
}