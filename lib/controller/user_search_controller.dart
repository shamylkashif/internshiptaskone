import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'auth_controller.dart';

class UserSearchController extends GetxController {

  final AuthController authController = Get.find<AuthController>();

  var results = <UserModel>[].obs;
  var loading = false.obs;

  Future<void> searchUsers(String query) async {

    if (query.isEmpty) {
      results.clear();
      return;
    }

    loading.value = true;

    try {
      final users = await UserService.searchUsers(
        token: authController.token.value,
        query: query,
      );

      results.value = users;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }
}
