import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request_model.dart';
import '../utils/api_endpoints.dart';

class RequestService {
  /// Send a request to another user
  static Future<void> sendRequest(String token, String toUserId) async {
    final url = Uri.parse("${ApiEndpoints.baseUrl}/api/requests/send");
    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"toUserId": toUserId}),
    );

    print("SendRequest status: ${res.statusCode}");
    print("SendRequest body: ${res.body}");

    if (res.statusCode == 200) {
      // Success, optionally parse response
      final data = jsonDecode(res.body);
      if (data["success"] == true) {
        print("Request sent successfully");
      } else {
        throw Exception(data["message"] ?? "Failed to send request");
      }
    } else {
      // Backend returned error (HTML or JSON)
      try {
        final data = jsonDecode(res.body);
        throw Exception(data["message"] ?? "Failed to send request");
      } catch (e) {
        // If parsing JSON fails, print body for debugging
        throw Exception("Failed to send request: ${res.body}");
      }
    }
  }


  /// Respond to a request (accept/reject)
  static Future<void> respondRequest(String token, String requestId, String action) async {
    final res = await http.post(
      Uri.parse("${ApiEndpoints.baseUrl}/api/requests/respond"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"requestId": requestId, "action": action}),
    );

    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["message"] ?? "Failed to respond to request");
    }
  }

  /// Get all pending requests for the logged-in user
  static Future<List<RequestModel>> getPendingRequests(String token) async {
    final res = await http.get(
      Uri.parse("${ApiEndpoints.baseUrl}/api/requests/pending"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)["requests"] as List;
      return data.map((json) => RequestModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch pending requests");
    }
  }
}
