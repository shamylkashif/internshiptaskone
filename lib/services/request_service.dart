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


  /// Respond to a request (accept / block)
  static Future<void> respondRequest(String token, String requestId, String action) async {
    final url = Uri.parse("${ApiEndpoints.baseUrl}/api/requests/respond");
    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"requestId": requestId, "action": action}),
    );

    if (res.statusCode != 200) {
      try {
        final data = jsonDecode(res.body);
        throw Exception(data["message"] ?? "Failed to respond to request");
      } catch (_) {
        throw Exception("Failed to respond to request: ${res.body}");
      }
    }
  }

  /// Get pending requests
  static Future<List<RequestModel>> getPendingRequests(String token) async {
    final url = Uri.parse("${ApiEndpoints.baseUrl}/api/requests/pending");
    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    print("PendingRequests status: ${res.statusCode}");
    print("PendingRequests body: ${res.body}");

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data["requests"] is List) {
        return (data["requests"] as List)
            .map((e) => RequestModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to fetch pending requests: ${res.body}");
    }
  }

  /// Get connections
  static Future<List<RequestModel>> getConnections(String token) async {
    final url = Uri.parse("${ApiEndpoints.baseUrl}/api/requests/connections");
    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data["connections"] is List) {
        return (data["connections"] as List)
            .map((e) => RequestModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to fetch connections: ${res.body}");
    }
  }

}
