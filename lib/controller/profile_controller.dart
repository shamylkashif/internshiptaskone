import 'package:get/get.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController {
  // TEMP user (replace with logged-in user later)
  Rx<UserModel> user = UserModel(
    id: "1",
    name: "Ali Khan",
    email: "ali@gmail.com",
    bio: "Flutter & Node.js Developer 🚀",
    interests: ["Flutter", "Node.js", "MongoDB"],
  ).obs;

  void logout() {
    // Later: clear storage / token
    Get.offAllNamed("LoginScreen");
  }
}
