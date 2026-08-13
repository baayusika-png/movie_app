import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = jsonDecode(response.body)["access_token"];

      final profileResponse = await http.get(
        Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (profileResponse.statusCode == 200) {
        return jsonDecode(profileResponse.body);
      }
    }

    return null;
  }
}
