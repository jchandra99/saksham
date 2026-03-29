import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/db_helper.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final DbHelper dbHelper;
  UserModel? _user;

  AuthProvider({required this.dbHelper});

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String username, String password) async {
    final user = await dbHelper.getUser(username, password);
    if (user != null) {
      _user = user;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('logged_in_user', username);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_in_user');
    notifyListeners();
  }

  Future<void> loadSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('logged_in_user');
    if (username != null) {
      final result = await dbHelper.getUser(username, 'dastak@2026');
      if (result != null) {
        _user = result;
      }
    }
    notifyListeners();
  }
}
