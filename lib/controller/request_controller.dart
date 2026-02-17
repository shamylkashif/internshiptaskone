import 'package:get/get.dart';
import '../models/request_model.dart';
import '../services/request_service.dart';
import 'auth_controller.dart';

class RequestController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  RxString relationshipStatus = "none".obs;
  RxBool isSender = false.obs;
  RxString currentRequestId = "".obs;
  RxBool loading = false.obs;

  RxList<RequestModel> pendingRequests = <RequestModel>[].obs;
  RxList<RequestModel> connections = <RequestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingRequests();
    fetchConnections();
  }


  // SEND REQUEST
  Future<void> sendRequest(String toUserId) async {
    try {
      loading.value = true;

      await RequestService.sendRequest(
        authController.token.value,
        toUserId,
      );

      Get.snackbar("Success", "Request sent successfully");

      // 🔥 refresh data
      await fetchPendingRequests();

      // 🔥 update UI immediately
      updateRelationship(toUserId);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }


  // RESPOND REQUEST (ACCEPT / REJECT)
  Future<void> respondRequest(String status) async {
    try {
      loading.value = true;

      await RequestService.respondRequest(
        authController.token.value,
        currentRequestId.value,
        status,
      );

      Get.snackbar("Success", "Request $status");

      // 🔥 refresh both lists
      await fetchPendingRequests();
      await fetchConnections();

      // 🔥 update relationship again
      updateRelationshipFromCurrent();

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }


  // UPDATE RELATIONSHIP
  void updateRelationship(String otherUserId) {
    final currentUserId = authController.currentUser.value?.id;
    if (currentUserId == null) return;

    // 1️⃣ Check accepted first
    final accepted = connections.firstWhereOrNull(
          (r) =>
      (r.fromUser?.id == currentUserId &&
          r.toUser?.id == otherUserId) ||
          (r.fromUser?.id == otherUserId &&
              r.toUser?.id == currentUserId),
    );

    if (accepted != null) {
      relationshipStatus.value = "accepted";
      currentRequestId.value = accepted.id ?? "";
      isSender.value = false;
      return;
    }

    // 2️⃣ Check pending
    final pending = pendingRequests.firstWhereOrNull(
          (r) =>
      (r.fromUser?.id == currentUserId &&
          r.toUser?.id == otherUserId) ||
          (r.fromUser?.id == otherUserId &&
              r.toUser?.id == currentUserId),
    );

    if (pending != null) {
      relationshipStatus.value = "pending";
      currentRequestId.value = pending.id ?? "";
      isSender.value = pending.fromUser?.id == currentUserId;
      return;
    }

    // 3️⃣ Nothing found
    relationshipStatus.value = "none";
    isSender.value = false;
    currentRequestId.value = "";
  }

  // helper after respond
  void updateRelationshipFromCurrent() {
    final currentUserId = authController.currentUser.value?.id;
    if (currentUserId == null) return;

    final request = connections.firstWhereOrNull(
          (r) =>
      r.fromUser?.id == currentUserId ||
          r.toUser?.id == currentUserId,
    );

    if (request != null) {
      final otherUserId = request.fromUser?.id == currentUserId
          ? request.toUser?.id
          : request.fromUser?.id;

      if (otherUserId != null) {
        updateRelationship(otherUserId);
      }
    }
  }


  // FETCH METHODS
  Future<void> fetchPendingRequests() async {
    final data = await RequestService.getPendingRequests(
      authController.token.value,
    );
    pendingRequests.value = data;
  }

  Future<void> fetchConnections() async {
    final data = await RequestService.getConnections(
      authController.token.value,
    );
    connections.value = data;
  }
}
