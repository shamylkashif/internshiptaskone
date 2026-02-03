import '../utils/app_imports.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller =
  Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.nameC,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller.bioC,
              decoration: const InputDecoration(labelText: "Bio"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            const Text("Interests"),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.interestC,
                    decoration:
                    const InputDecoration(hintText: "Add interest"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: controller.addInterest,
                )
              ],
            ),

            const SizedBox(height: 10),

            Obx(() => Wrap(
              spacing: 8,
              children: controller.interests
                  .map((interest) => Chip(
                label: Text(interest),
                onDeleted: () =>
                    controller.removeInterest(interest),
              ))
                  .toList(),
            )),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.saveProfile,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
