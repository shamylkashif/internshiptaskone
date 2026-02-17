import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate chatId for 1:1 chats (sorted IDs to avoid duplicates)
  String generateChatId(String userId1, String userId2) {
    final sorted = [userId1, userId2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  /// Send a message
  Future<void> sendMessage({
    required String senderId,
    required String senderName,
    required String senderImage,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required String text,
  }) async {
    final chatId = generateChatId(senderId, receiverId);

    final chatDoc = _firestore.collection('chats').doc(chatId);
    final messagesCol = chatDoc.collection('messages');

    final timestamp = FieldValue.serverTimestamp();

    // 1️⃣ Update chat document (last message, participants, images)
    await chatDoc.set({
      'participants': [senderId, receiverId],
      'userNames': {
        senderId: senderName,
        receiverId: receiverName,
      },
      'userImages': {
        senderId: senderImage,
        receiverId: receiverImage,
      },
      'lastMessage': text,
      'lastMessageTime': timestamp,
    }, SetOptions(merge: true));

    // 2️⃣ Add message to messages subcollection
    await messagesCol.add({
      'senderId': senderId,
      'text': text,
      'type': 'text',
      'timestamp': timestamp,
      'readBy': [senderId], // sender has read it
    });
  }

  /// Listen to messages in a chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId1, String userId2) {
    final chatId = generateChatId(userId1, userId2);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  /// Fetch all chats for a user (chat list)
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  /// Mark a message as read
  Future<void> markMessageRead(String chatId, String messageId, String userId) async {
    final msgRef = _firestore.collection('chats').doc(chatId).collection('messages').doc(messageId);
    await msgRef.update({
      'readBy': FieldValue.arrayUnion([userId]),
    });
  }
}
