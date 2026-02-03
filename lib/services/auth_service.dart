
import 'package:http/http.dart' as http;

import '../utils/app_imports.dart';
import '../utils/api_endpoints.dart';

class AuthService {
  // Login API call
  static Future<Map<String, dynamic>> login(String email,
      String password) async {
    try {
      final res = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return {"success": false, "message": jsonDecode(res.body)["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // Signup API call
  static Future<Map<String, dynamic>> signup(String name, String email,
      String password) async {
    try {
      final res = await http.post(
        Uri.parse(ApiEndpoints.signup),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (res.statusCode == 201) {
        return jsonDecode(res.body);
      } else {
        return {"success": false, "message": jsonDecode(res.body)["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
