import '../models/user_model.dart';
import '../utils/app_imports.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller =
  Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final user = controller.user.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _profileHeader(user),
              const SizedBox(height: 20),
              _bioSection(user.bio),
              const SizedBox(height: 20),
              _interestChips(user.interests),
              const SizedBox(height: 30),
              _statsRow(),
              const SizedBox(height: 30),
              _actionButtons(),
            ],
          ),
        );
      }),
    );
  }

  Widget _profileHeader(UserModel user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor:
          AppConstants.primaryColor.withValues(alpha: 0.1),
          child: const Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 10),
        Text(user.name ?? "", style: AppConstants.heading1),
        const SizedBox(height: 5),
        Text(user.email ?? "", style: AppConstants.smallText),
      ],
    );
  }

  Widget _bioSection(String? bio) {
    return Text(
      bio ?? "",
      style: AppConstants.bodyText,
      textAlign: TextAlign.center,
    );
  }

  Widget _interestChips(List<String>? interests) {
    if (interests == null || interests.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: interests
          .map(
            (interest) => Chip(
          label: Text(interest),
          backgroundColor:
          AppConstants.primaryColor.withValues(alpha: 0.15),
        ),
      )
          .toList(),
    );
  }

  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem("Chats", "12"),
        _statItem("Connections", "34"),
      ],
    );
  }

  Widget _statItem(String title, String count) {
    return Column(
      children: [
        Text(count, style: AppConstants.heading1),
        const SizedBox(height: 4),
        Text(title, style: AppConstants.smallText),
      ],
    );
  }

  Widget _actionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            onPressed: () {
            },
            child: Text("Edit Profile", style: AppConstants.bodyText),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: controller.logout,
            child: const Text("Logout"),
          ),
        ),
      ],
    );
  }
}
