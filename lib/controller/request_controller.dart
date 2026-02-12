import 'package:get/get.dart';
import '../models/request_model.dart';
import '../services/request_service.dart';
import 'auth_controller.dart';

class RequestController extends GetxController {
  var loading = false.obs;
  var pendingRequests = <RequestModel>[].obs;
  var connections = <RequestModel>[].obs;


  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchConnections();
    fetchPendingRequests();
  }

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

  Future<void> fetchPendingRequests() async {
    try {
      loading.value = true;

      final data = await RequestService.getPendingRequests(
          authController.token.value);

      pendingRequests.assignAll(data);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchConnections() async {
    try {
      loading.value = true;

      final data = await RequestService.getConnections(
          authController.token.value);

      connections.assignAll(data);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

}
