import '../models/user_model.dart';
import '../services/user_service.dart';
import 'package:internshiptaskone/utils/app_imports.dart';

import 'auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  // Reactive local user
  var user = Rxn<UserModel>();
  var loading = false.obs;

  // Getter to access currentUser easily
  UserModel? get currentUser => user.value ?? authController.currentUser.value;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    loading.value = true;
    try {
      final profile = await UserService.getMyProfile(authController.token.value);
      user.value = profile;
      // Optional: sync with AuthController
      authController.currentUser.value = profile;
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateProfile(String name, String bio, List<String> interests) async {
    loading.value = true;
    try {
      final updatedUser = await UserService.updateProfile(
        token: authController.token.value,
        name: name,
        bio: bio,
        interests: interests,
      );

      user.value = updatedUser;
      authController.currentUser.value = updatedUser; // keep AuthController in sync
    } finally {
      loading.value = false;
      Get.back();
    }
  }
}
