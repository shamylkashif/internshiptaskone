import 'package:get/get.dart';
import '../models/chat_model.dart';

class ChatController extends GetxController {
  RxList<Chat> chats = <Chat>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  void fetchChats() async {
    isLoading.value = true;

    // ⏳ TEMPORARY: simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // ✅ CASE 1: No chats (EMPTY STATE)
    // chats.clear();

    // ✅ CASE 2: Chats exist
    chats.assignAll([
      Chat(
        name: "Alice",
        lastMessage: "Hey, how are you?",
        time: "10:00 AM",
      ),
      Chat(
        name: "Bob",
        lastMessage: "Let's meet tomorrow.",
        time: "9:30 AM",
      ),
      Chat(
        name: "Charlie",
        lastMessage: "Check this out!",
        time: "Yesterday",
      ),
      Chat(
        name: "David",
        lastMessage: "Call me back.",
        time: "Yesterday",
      ),
    ]);

    isLoading.value = false;
  }
}
