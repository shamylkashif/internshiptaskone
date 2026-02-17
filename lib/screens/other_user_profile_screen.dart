import '../controller/request_controller.dart';
import '../models/user_model.dart';
import '../utils/app_imports.dart';


class OtherUserProfileScreen extends StatelessWidget {
  final UserModel user;
  final RequestController requestController = Get.find<RequestController>();


  OtherUserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Ensure relationship status is updated whenever screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestController.updateRelationship(user.id!);
    });

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(automaticallyImplyLeading: true),
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
          backgroundColor: AppConstants.primaryColor.withValues(alpha: 0.1),
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
    if (interests == null || interests.isEmpty) return const SizedBox();

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
    return Obx(() {
      final status = requestController.relationshipStatus.value;
      final isSender = requestController.isSender.value;

      // No relationship yet → show "Send Request"
      if (status == "none") {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => requestController.sendRequest(user.id!),
            child: const Text("Send Request"),
          ),
        );
      }

      // Pending request
      if (status == "pending") {
        // Sender sees "Pending"
        if (isSender) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              child: const Text("Pending"),
            ),
          );
        }
        // Receiver sees "Accept / Reject"
        else {
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      requestController.respondRequest("accepted"),
                  child: const Text("Accept"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      requestController.respondRequest("blocked"),
                  child: const Text("Reject"),
                ),
              ),
            ],
          );
        }
      }

      // Accepted → show Chat
      if (status == "accepted") {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to chat screen
            },
            child: const Text("Chat"),
          ),
        );
      }

      // Blocked
      if (status == "blocked") {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: null,
            child: const Text("Blocked"),
          ),
        );
      }

      return const SizedBox();
    });
  }
}
