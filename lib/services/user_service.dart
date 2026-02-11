import 'dart:convert';
import 'dart:io';
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
    File? imageFile,
  }) async {
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse(ApiEndpoints.updateProfile),
    );

    request.headers["Authorization"] = "Bearer $token";

    request.fields["name"] = name;
    request.fields["bio"] = bio;
    request.fields["interests"] = jsonEncode(interests);

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "profileImage",
          imageFile.path,
        ),
      );
    }

    var response = await request.send();

    var resBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(resBody));
    } else {
      throw Exception("Profile update failed");
    }
  }


  static Future<List<UserModel>> searchUsers({
    required String token,
    required String query,
  }) async {
    final res = await http.get(
      Uri.parse("${ApiEndpoints.baseUrl}/api/users/search?query=$query"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Search failed");
    }
  }

}
