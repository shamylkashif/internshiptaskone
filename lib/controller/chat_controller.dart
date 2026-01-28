import 'package:get/get.dart';

import '../models/chat_model.dart';

class ChatController extends GetxController {
  var chats = <Chat>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy data
    chats.addAll([
      Chat(name: "Alice", lastMessage: "Hey, how are you?", time: "10:00 AM"),
      Chat(name: "Bob", lastMessage: "Let's meet tomorrow.", time: "9:30 AM"),
      Chat(name: "Charlie", lastMessage: "Check this out!", time: "Yesterday"),
      Chat(name: "David", lastMessage: "Call me back.", time: "Yesterday"),
    ]);
  }
}
