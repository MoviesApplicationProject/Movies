import 'package:flutter/material.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<void> logoutUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token'); // حذف التوكن
      await prefs.reload(); // إعادة تحميل القيم المخزنة

      print('🚪 Logout successful');
      print("Token after logout: ${prefs.getString('auth_token')}");

      // ⏪ إعادة توجيه المستخدم لشاشة تسجيل الدخول
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getString('auth_token') != null;
    print("🔍 Is user logged in? $loggedIn");
    return loggedIn;
  }
}
