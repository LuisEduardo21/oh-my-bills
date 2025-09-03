import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Simulate login and set token (replace with actual authentication logic)
  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Replace with actual authentication logic (e.g., API call)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'mock_token');

      _isLoading = false;
      notifyListeners();
      return true; // Login successful
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Login failed: $e';
      notifyListeners();
      return false; // Login failed
    }
  }

  // Check if token exists
  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }
}
