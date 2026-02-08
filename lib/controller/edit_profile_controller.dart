import 'package:internshiptaskone/controller/profile_controller.dart';

import '../controller/auth_controller.dart';
import '../utils/app_imports.dart';

class EditProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();


  late TextEditingController nameC;
  late TextEditingController bioC;
  late TextEditingController interestC;

  RxList<String> interests = <String>[].obs;

  @override
  void onInit() {
    final user = authController.currentUser.value!;

    nameC = TextEditingController(text: user.name);
    bioC = TextEditingController(text: user.bio);
    interestC = TextEditingController();

    interests.assignAll(user.interests ?? []);

    super.onInit();
  }

  void addInterest() {
    if (interestC.text.trim().isNotEmpty) {
      interests.add(interestC.text.trim());
      interestC.clear();
    }
  }

  void removeInterest(String interest) {
    interests.remove(interest);
  }

  void saveProfile() {
    profileController.updateProfile(
      nameC.text.trim(),
      bioC.text.trim(),
      interests,
    );
  }

}
