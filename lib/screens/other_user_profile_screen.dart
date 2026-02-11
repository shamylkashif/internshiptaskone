import '../controller/request_controller.dart';
import '../models/user_model.dart';
import '../utils/app_imports.dart';

class OtherUserProfileScreen extends StatelessWidget {
  final UserModel user;

  OtherUserProfileScreen({super.key, required this.user});
  final RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }

  // ---------------- PROFILE HEADER ----------------

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

  // ---------------- BIO ----------------

  Widget _bioSection(String? bio) {
    return Text(
      bio ?? "",
      style: AppConstants.bodyText,
      textAlign: TextAlign.center,
    );
  }

  // ---------------- INTEREST CHIPS ----------------

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

  // ---------------- STATS ----------------
  // (You can connect these later with Firestore)

  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem("Chats", "0"),
        _statItem("Connections", "0"),
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

  // ---------------- ACTION BUTTON ----------------

  Widget _actionButtons() {
    return SizedBox(
      width: double.infinity,
      child: Obx((){
        return   ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
          ),
          onPressed: requestController.loading.value
              ? null
              : () => requestController.sendRequest(user.id!),
          child: requestController.loading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Send Request", style: AppConstants.bodyText,),
        );
      })
    );
  }
}
