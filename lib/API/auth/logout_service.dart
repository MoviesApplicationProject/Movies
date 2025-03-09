import 'package:flutter/material.dart';
import 'package:movies/core/utils/dialog_utils.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<void> logoutUser(BuildContext context) async {
    try {
      showLoading(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userId = prefs.getString('user_id'); // ✅ الاحتفاظ بالـ user_id
      await prefs.clear(); // ❌ يمسح كل شيء، لا نستخدمه هنا
      await prefs.setString(
          'user_id', userId ?? ""); // ✅ إعادة تخزين الـ user_id

      await prefs.remove('auth_token');
      await prefs.reload();

      print('🚪 Logout successful');
      print("Token after logout: ${prefs.getString('auth_token')}");
      hideLoading(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      hideLoading(context);
      print('❌ Logout error: $e');
      showMessage(context, e.toString());
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getString('auth_token') != null;
    print("🔍 Is user logged in? $loggedIn");
    return loggedIn;
  }
}
