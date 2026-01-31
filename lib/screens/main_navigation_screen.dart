import 'package:internshiptaskone/screens/chat_list_screen.dart';
import 'package:internshiptaskone/screens/profile_screen.dart';
import 'package:internshiptaskone/screens/search_users_screen.dart';
import 'package:internshiptaskone/notification/notifications.dart';
import 'package:internshiptaskone/utils/app_imports.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({super.key});

  final RxInt currentIndex = 1.obs;

  final List<Widget> pages = [
    SearchUsersScreen(),
    ChatListScreen(),
    Notifications(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: IndexedStack(
        index: currentIndex.value,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          currentIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    ));
  }
}
