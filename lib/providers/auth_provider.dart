import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String? name;
  String? email;
  String? image;

  Future<bool> loginUser(String email, String password) async {
    final user = await _service.login(email, password);

    if (user != null) {
      _isLoggedIn = true;

      name = user["name"];
      this.email = user["email"];
      image = user["avatar"];

      notifyListeners();

      return true;
    }

    return false;
  }

  void logout() {
    _isLoggedIn = false;

    name = null;
    email = null;
    image = null;

    notifyListeners();
  }
}
