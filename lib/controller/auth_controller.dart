import 'package:internshiptaskone/screens/chat_list_screen.dart';
import '../screens/authentication/login_screen.dart';
import '../utils/app_imports.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  // Loading state for UI
  var loading = false.obs;

  // Login function
  Future<void> login(String email, String password) async {
    loading.value = true;
    try {
      final res = await AuthService.login(email, password);
      loading.value = false;
      if (res['success']) {
        Get.snackbar("Success", "Logged in successfully");
        Get.to(ChatListScreen());
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
        Get.snackbar("Success", "Account created successfully");
        Get.offAll(LoginScreen());// Navigate back to login
      } else {
        Get.snackbar("Error", res['message']);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
