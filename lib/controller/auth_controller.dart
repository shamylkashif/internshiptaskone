import 'package:internshiptaskone/screens/main_navigation_screen.dart';
import '../models/user_model.dart';
import '../screens/authentication/login_screen.dart';
import '../utils/app_imports.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  RxString token = "".obs;
  // Loading state for UI
  var loading = false.obs;

  // Login function
  Future<void> login(String email, String password) async {
    loading.value = true;
    try {
      final res = await AuthService.login(email, password);
      loading.value = false;
      if (res['success']) {
        token.value = res["token"];
        currentUser.value = UserModel.fromJson(res["user"]);
        Get.to(MainNavigationScreen());
      } else {
        Get.snackbar("Error", res['message']);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  // Signup function
  Future<void> signup(String name, String email, String password) async {
    loading.value = true;
    try {
      final res = await AuthService.signup(name, email, password);
      loading.value = false;
      if (res['success']) {
        currentUser.value = UserModel.fromJson(res["user"]);
        token.value = res["token"];
        Get.offAll(LoginScreen());// Navigate back to login
      } else {
        Get.snackbar("Error", res['message']);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
  void logout() {
    currentUser.value = null;
    Get.offAll(LoginScreen());
  }
}
