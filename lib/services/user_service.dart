import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../utils/api_endpoints.dart';

class UserService {
  static Future<UserModel> getMyProfile(String token) async {
    final res = await http.get(
      Uri.parse(ApiEndpoints.myProfile),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load profile");
    }
  }

  static Future<UserModel> updateProfile({
    required String token,
    required String name,
    required String bio,
    required List<String> interests,
  }) async {
    final res = await http.put(
      Uri.parse(ApiEndpoints.updateProfile),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "bio": bio,
        "interests": interests,
      }),
    );

    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Profile update failed");
    }
  }
}
