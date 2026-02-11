import 'package:get/get.dart';
import '../services/request_service.dart';
import 'auth_controller.dart';

class RequestController extends GetxController {
  var loading = false.obs;

  final AuthController authController = Get.find<AuthController>();

  Future<void> sendRequest(String toUserId) async {
    try {
      loading.value = true;
      await RequestService.sendRequest(authController.token.value, toUserId);
      Get.snackbar("Success", "Request sent successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }
}
