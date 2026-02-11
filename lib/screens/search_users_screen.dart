import 'dart:async';
import 'package:internshiptaskone/screens/other_user_profile_screen.dart';
import '../controller/user_search_controller.dart';
import '../utils/app_imports.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({super.key});

  @override
  State<SearchUsersScreen> createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {

  final UserSearchController controller = Get.put(UserSearchController());

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Search users or interests...",
            border: InputBorder.none,
          ),
          onChanged: (value) {

            if (_debounce?.isActive ?? false) _debounce!.cancel();

            _debounce = Timer(const Duration(milliseconds: 400), () {
              controller.searchUsers(value);
            });
          },
        ),
      ),
      body: Obx(() {

        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.results.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        return ListView.builder(
          itemCount: controller.results.length,
          itemBuilder: (_, index) {

            final user = controller.results[index];

            return ListTile(
              title: Text(user.name ?? ""),
              subtitle: Text(user.interests?.join(", ") ?? ""),
              onTap: (){
                Get.to(() => OtherUserProfileScreen(user: user));
              },
            );
          },
        );
      }),
    );
  }
}
